//
//  AttendanceViewModel.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/20.
//

import Foundation
import Firebase
import FirebaseFirestore

class AttendanceViewModel: ObservableObject {
    @Published var weatherCondition = Weather.clear.rawValue
    @Published var eyeDirection: [Float] = [Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1)]
    @Published var attendanceRecord: AttendanceRecord? = nil
    @Published var currentRecord: AttendanceRecord?
    
    private var firestoreManager: FirestoreManager {
        FirestoreManager.shared
    }
    private var db: Firestore {
        firestoreManager.db
    }
    private let currentUser = Auth.auth().currentUser
    

    // function to get the weather condition
    func fetchWeatherCondition() {
        // this is a placeholder, replace with real code to fetch weather condition
        self.weatherCondition = Weather.clear.rawValue
    }
    
    func createAttendanceRecord() {
        currentRecord = AttendanceRecord(userId: currentUser?.uid ?? "", date: Date(), weatherCondition: weatherCondition, eyeDirection: eyeDirection)
    }

    func ensureCurrentRecord() -> AttendanceRecord {
        if currentRecord == nil {
            createAttendanceRecord()
        }

        // Since we just created a record if it was nil, we can force unwrap here
        return currentRecord!
    }
}
