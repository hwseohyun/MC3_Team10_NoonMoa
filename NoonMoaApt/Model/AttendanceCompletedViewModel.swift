//
//  AttendanceCompletedViewModel.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/20.
//

import Foundation
import Firebase
import FirebaseFirestore

class AttendanceCompletedViewModel: ObservableObject {
    @Published var userId: String
    @Published var weatherCondition: String
    @Published var eyeDirection: [Float]
    @Published var attendanceRecord: AttendanceRecord? = nil
    @Published var user: User? = nil
    private let currentUser = Auth.auth().currentUser

    private var firestoreManager: FirestoreManager {
        FirestoreManager.shared
    }
    private var db: Firestore {
        firestoreManager.db
    }

    init(record: AttendanceRecord) {
        self.userId = currentUser?.uid ?? ""
        self.weatherCondition = record.weatherCondition
        self.eyeDirection = record.eyeDirection
        self.attendanceRecord = record
    }
    
    func saveAttendanceRecord(record: AttendanceRecord) {
        let newRecord = record
        print("AttendanceRecord newRecord.userId: \(newRecord.userId)")
        
        db.collection("User").document(userId).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                do {
                    let newRecordRef = try db.collection("AttendanceRecord").addDocument(from: newRecord)
                    self.attendanceRecord = newRecord
                    print("AttendanceRecord")
                    
                    // Create a new AttendanceSheet if it doesn't exist
                    let attendanceSheetRef = db.collection("AttendanceSheet").document(userId)
                    attendanceSheetRef.getDocument { [self] (document, error) in
                        if let document = document, document.exists {
                            // If the AttendanceSheet exists, update it
                            attendanceSheetRef.updateData([
                                "attendanceRecords": FieldValue.arrayUnion([newRecordRef.documentID])
                            ])
                        } else {
                            // If the AttendanceSheet doesn't exist, create a new one
                            let newAttendanceSheet = AttendanceSheet(id: self.userId, attendanceRecords: [newRecordRef.documentID], userId: userId)
                            do {
                                try attendanceSheetRef.setData(from: newAttendanceSheet)
                            } catch let error {
                                print("Error writing new attendance sheet to Firestore: \(error)")
                            }
                        }
                    }
                    
                } catch let error {
                    print("Error writing new attendance record to Firestore: \(error)")
                }
            } else {
                print("saveAttendanceRecord: User does not exist!")
            }
        }
    }
    
    func updateUserLastActiveDate() {
        guard !userId.isEmpty else {
            print("Error: User ID is empty.")
            return
        }
        
        // Fetch the User document first
        db.collection("User").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let user = try? document.data(as: User.self)
                
                // Now update the User document with lastActiveDate and state only
                self.db.collection("User").document(self.userId).updateData([
                    "lastActiveDate": Date()
//                    "userState": UserState.active.rawValue
                ])
            } else {
                print("updateUserLastActiveDate: User does not exist!")
            }
        }
    }
    
    func updateRecord(newRecord: AttendanceRecord) {
        self.userId = newRecord.userId
        self.weatherCondition = newRecord.weatherCondition
        self.eyeDirection = newRecord.eyeDirection
        self.attendanceRecord = newRecord
    }
}
