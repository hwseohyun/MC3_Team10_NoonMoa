//
//  AttendanceModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct AttendanceRecord: Codable, Identifiable {
    @DocumentID var id: String? // = UUID().uuidString <- 이 부분 제거
    var userId: String
    
    var date: Date
    
    var rawIsSmiling: Bool
    var rawIsBlinkingLeft: Bool
    var rawIsBlinkingRight: Bool
    var rawLookAtPoint: [Float]
    var rawFaceOrientation: [Float]
    var rawCharacterColor: [Float]
    
    var rawWeather: String
    var rawTime: Date
    var rawtSunriseTime: Date
    var rawSunsetTime: Date
}


class AttendanceModel: ObservableObject {
    
    private var characterModel: CharacterModel = CharacterModel()
    private var environmentModel: EnvironmentModel = EnvironmentModel()
    
    @Published var newAttendanceRecord: AttendanceRecord? = nil
    
    init(newAttendanceRecord: AttendanceRecord) {
        // Initialize characterModel and environmentModel here
        self.newAttendanceRecord = newAttendanceRecord
    }

    // 출석도장 찍거나 설정창에서 바꿀 때
    func uploadAttendanceRecord() {
        environmentModel.getCurrentEnvironment()
        environmentModel.saveRawEnvironmentToAttendanceModel()
        characterModel.getCurrentCharacter()
        characterModel.saveRawCharacterToAttendanceModel()
        // 마지막으로 Firebase에 Date를 key 값으로 사용하여, userId를 포함한 newAttendanceRecord를 기록한다!!!
        // Example of saving the newAttendanceRecord to Firebase:
        if let newRecord = newAttendanceRecord {
            saveAttendanceRecordToFirebase(record: newRecord)
        }
    }

    // 앱이 켜질 때 다운로드
    func downloadAttendanceRecords(key: Date) {
        let attendanceRecords = fetchAttendanceRecords()//추후 반복문 실행 시 밖으로 꺼낼 것
        if let record = attendanceRecords[key] {
            environmentModel.fetchRecordedEnvironment(record: record)
            characterModel.fetchRecordedCharacter(record: record)
        }
    }

    func fetchAttendanceRecords() -> [Date: AttendanceRecord] {
        // Fetch attendance records from Firebase and return them as [Date: AttendanceRecord]
        // Example of fetching from Firebase and converting to the desired dictionary format:
        // var records = [Date: AttendanceRecord]()
        // ... Fetch records from Firebase ...
        // for record in fetchedRecords {
        //     records[record.rawTime] = record
        // }
        // return records
        return [:] // Placeholder: Replace this with the actual fetched records
    }

    // Example of saving the attendance record to Firebase
    func saveAttendanceRecordToFirebase(record: AttendanceRecord) {
        // ... Save the record to Firebase ...
        // Firestore.firestore().collection("attendanceRecords").addDocument(from: record) { error in
        //    if let error = error {
        //        print("Error adding document: \(error)")
        //    } else {
        //        print("Document added with ID: \(record.id ?? "")")
        //    }
        // }
    }
}
