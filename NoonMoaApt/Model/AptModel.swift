    //
    //  AptViewModel.swift
    //  MangMongApt
    //
    //  Created by kimpepe on 2023/07/20.
    //

    import Foundation
    import Firebase
    import FirebaseFirestore

    class AptModel: ObservableObject {
        @Published var apt: Apt?
        @Published var rooms: [Room] = []
        @Published var users: [User] = []
        @Published var user: User?
        @Published var roomUserMap: [String: User] = [:] // New published property

        
        private var firestoreManager: FirestoreManager {
            FirestoreManager.shared
        }
        private var db: Firestore {
            firestoreManager.db
        }
        private var userListener: ListenerRegistration?
        
        // Fetch current user's apartment
        func fetchCurrentUserApt() {
            guard let userId = Auth.auth().currentUser?.uid else { return }  // Exit if no user ID is found
            let docRef = db.collection("User").document(userId)
            docRef.getDocument { (document, error) in
                guard let document = document, document.exists,
                      let user = try? document.data(as: User.self),
                      let aptId = user.aptId else { return }  // Exit if no document, user, or apartment ID found
                self.fetchApartment(aptId: aptId)
            }
        }
        
        // Fetch apartment details
        private func fetchApartment(aptId: String) {
            let aptRef = db.collection("Apt").document(aptId)
            aptRef.getDocument { (aptDocument, aptError) in
                guard let aptDocument = aptDocument, aptDocument.exists,
                      let apt = try? aptDocument.data(as: Apt.self) else { return }  // Exit if no apartment document or apartment data found
                self.apt = apt
                self.fetchRoomsAndUsers()
            }
        }
        
        // Fetch rooms and users
        private func fetchRoomsAndUsers() {
            guard let aptId = self.apt?.id else { return }  // Exit if no apartment ID is found
            db.collection("Room").whereField("aptId", isEqualTo: aptId).getDocuments { (roomQuerySnapshot, roomError) in
                guard let roomQuerySnapshot = roomQuerySnapshot else { return }  // Exit if no roomQuerySnapshot is found
                self.rooms = roomQuerySnapshot.documents.compactMap { try? $0.data(as: Room.self) }  // Map to Room objects
                self.fetchUsers()
            }
        }
        
        // Fetch users
        private func fetchUsers() {
            self.rooms.forEach { room in
                self.userListener = db.collection("User").document(room.userId).addSnapshotListener { (documentSnapshot, error) in
                    guard let documentSnapshot = documentSnapshot, documentSnapshot.exists,
                          let user = try? documentSnapshot.data(as: User.self) else { print("Error fetching user: \(error)"); return }  // Print error if any issues fetching user
                    DispatchQueue.main.async {
                        self.updateUserList(user: user)
                        self.updateRoomUserMap(room: room, user: user) // Update the map after updating user list
                    }
                }
            }
        }
        
        // Update user list
        private func updateUserList(user: User) {
            if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                self.users[index] = user
            } else {
                self.users.append(user)
            }
        }

        // New method to update Room: User map
        private func updateRoomUserMap(room: Room, user: User) {
            if let roomId = room.id {
                self.roomUserMap[roomId] = user
            }
        }
        
        deinit {
            userListener?.remove()  // Detach the listener when you're done
        }
    }
