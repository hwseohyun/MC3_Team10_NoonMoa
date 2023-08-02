////  DummyData.swift
////  MangMongApt
////
////  Created by kimpepe on 2023/07/16.
////
//
//import Foundation
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class DummyData: ObservableObject {
//    private var firestoreManager: FirestoreManager {
//        FirestoreManager.shared
//    }
//    private var db: Firestore {
//        firestoreManager.db
//    }
//
//    // Create dummy data
//    func createDummyData(aptId: String) {
//        db.collection("Apt").document(aptId).getDocument { [self] (document, error) in
//            if let document = document, document.exists {
//                let apt = try? document.data(as: Apt.self)
//                
//                // Create a dummy room only when it's the first room in the apartment
//                if apt?.rooms.count == 1 {
//                    let roomCounterRef = db.collection("globals").document("roomCounter")
//                    roomCounterRef.getDocument { (document, error) in
//                        if let document = document, document.exists {
//                            // Get the current room count
//                            var roomCount = document.data()?["count"] as? Int ?? 0
//                            
//                            // Increment the room count
//                            roomCount += 1
//                            
//                            // Create a new room (aptId will be assigned later)
//                            let newRoomId = "\(roomCount)"
//                            let newRoom = Room(id: newRoomId, aptId: aptId, number: roomCount, userId: "")
//                            
//                            // Add the new room to the Room collection
//                            do {
//                                try self.db.collection("Room").document(newRoomId).setData(from: newRoom)
//                            } catch let error {
//                                print("Error adding new room to Firestore: \(error)")
//                            }
//                            
//                            // Update the global room counter
//                            roomCounterRef.setData(["count": roomCount], merge: true) { err in
//                                if let err = err {
//                                    print("Error updating global room counter: \(err)")
//                                } else {
//                                    print("Global room counter updated")
//                                }
//                            }
//
//                            // Update the apt with the new room
//                            self.db.collection("Apt").document(aptId).updateData([
//                                "rooms": FieldValue.arrayUnion([newRoomId]),
//                                "roomCount": FieldValue.increment(Int64(1))
//                            ]) { err in
//                                if let err = err {
//                                    print("Error updating apt: \(err)")
//                                } else {
//                                    print("Apt updated with new room")
//                                }
//                            }
//
//                            let dummyUserId = UUID().uuidString
//                            let dummyUser = User(id: dummyUserId, roomId: newRoomId, aptId: aptId, userState: UserState.sleep.rawValue, lastActiveDate: Date(), characterColor: CharacterColor.blue.rawValue, token: "", requestedBy: [])
//
//                            do {
//                                try self.db.collection("User").document(dummyUserId).setData(from: dummyUser)
//                            } catch let error {
//                                print("Error writing dummy user to Firestore: \(error)")
//                            }
//
//                            // Add the dummy user to the room
//                            self.db.collection("Room").document(newRoomId).updateData([
//                                "userId": dummyUserId
//                            ]) { err in
//                                if let err = err {
//                                    print("Error updating room: \(err)")
//                                } else {
//                                    print("Room updated with dummy user")
//                                }
//                            }
//
//                        }
//                    }
//                }
//            } else {
//                print("Apt does not exist!")
//            }
//        }
//    }
//}
