//
//  CharacterModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation

class CharacterModel: ObservableObject {
    
    var rawIsSmiling: Bool = false
    var rawIsBlinkingLeft: Bool = false
    var rawIsBlinkingRight: Bool = false
    var rawLookAtPoint: [Float] = [0.0, 0.0, 0.0]
    var rawFaceOrientation: [Float] = [0.0, 0.0, 0.0]
    var rawCharacterColor: [Float] = [0.0, 0.0, 0.0]
    
    var currentIsSmiling: Bool = false
    var currentIsBlinkingLeft: Bool = false
    var currentIsBlinkingRight: Bool = false
    var currentLookAtPoint: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    var currentFaceOrientation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    var currentCharacterColor: [Float] = [0.0, 0.0, 0.0]
    
    var recordedRawIsSmiling: Bool = false
    var recordedRawIsBlinkingLeft: Bool = false
    var recordedRawIsBlinkingRight: Bool = false
    var recordedRawLookAtPoint: [Float] = [0.0, 0.0, 0.0]
    var recordedRawFaceOrientation: [Float] = [0.0, 0.0, 0.0]
    var recordedRawCharacterColor: [Float] = [0.0, 0.0, 0.0]
    
    var recordedIsSmiling: Bool = false
    var recordedIsBlinkingLeft: Bool = false
    var recordedIsBlinkingRight: Bool = false
    var recordedLookAtPoint: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    var recordedFaceOrientation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    var recordedCharacterColor: [Float] = [0.0, 0.0, 0.0]
    
    func getCurrentCharacter() {
        getCurrentCharacterViewData()
        convertViewDataToRawCharacter(isSmiling: currentIsSmiling, isBlinkingLeft: currentIsBlinkingLeft, isBlinkingRight: currentIsBlinkingRight, lookAtPoint: currentLookAtPoint, faceOrientation: currentFaceOrientation, characterColor: currentCharacterColor)
    }
    
    func getCurrentCharacterViewData() {
        currentIsSmiling = EyeMyViewModel().isSmiling
        currentIsBlinkingLeft = EyeMyViewModel().isBlinkingLeft
        currentIsBlinkingRight = EyeMyViewModel().isBlinkingRight
        currentLookAtPoint = EyeMyViewModel().lookAtPoint
        currentFaceOrientation = EyeMyViewModel().faceOrientation
        currentCharacterColor = CustomViewModel().currentCharacterColor
    }
    
    //AttendanceModel을 통해 저장할 때 사용
    func convertViewDataToRawCharacter(isSmiling: Bool, isBlinkingLeft: Bool, isBlinkingRight: Bool, lookAtPoint: SIMD3<Float>, faceOrientation: SIMD3<Float>, characterColor: [Float]) {
        rawIsSmiling = isSmiling
        rawIsBlinkingLeft = isBlinkingLeft
        rawIsBlinkingRight = isBlinkingRight
        rawLookAtPoint = [Float(lookAtPoint.x), Float(lookAtPoint.y), Float(lookAtPoint.z)]
        rawFaceOrientation = [Float(faceOrientation.x), Float(faceOrientation.y), Float(faceOrientation.z)]
        rawCharacterColor = characterColor
    }
    
    func saveRawCharacterToAttendanceModel()  {
        //attendanceModel.newAttendanceRecord(...)
    }
    
    //AttendanceModel을 통해 받아올 때 사용한다.
    func fetchRecordedCharacter(record: AttendanceRecord) {
        saveRecordedRawCharacterToCharacterModel(record: record)
        convertRawCharacterToViewData(isSmiling: recordedRawIsSmiling, isBlinkingLeft: recordedRawIsBlinkingLeft, isBlinkingRight: recordedRawIsBlinkingRight, lookAtPoint: recordedRawLookAtPoint, faceOrientation: recordedRawFaceOrientation, characterColor: recordedRawCharacterColor)
    }
    
    func saveRecordedRawCharacterToCharacterModel(record: AttendanceRecord) {
        recordedRawIsSmiling = record.rawIsSmiling
        recordedRawIsBlinkingLeft = record.rawIsBlinkingLeft
        recordedRawIsBlinkingRight = record.rawIsBlinkingRight
        recordedRawLookAtPoint = record.rawLookAtPoint
        recordedRawFaceOrientation = record.rawFaceOrientation
        recordedRawCharacterColor = record.rawCharacterColor
    }
    
    func convertRawCharacterToViewData(isSmiling: Bool, isBlinkingLeft: Bool, isBlinkingRight: Bool, lookAtPoint: [Float], faceOrientation: [Float], characterColor: [Float] ) {
        recordedIsSmiling = isSmiling
        recordedIsBlinkingLeft = isBlinkingLeft
        recordedIsBlinkingRight = isBlinkingRight
        recordedLookAtPoint = SIMD3<Float>(lookAtPoint[0], lookAtPoint[1], lookAtPoint[2])
        recordedFaceOrientation = SIMD3<Float>(faceOrientation[0], faceOrientation[1], faceOrientation[2])
        recordedCharacterColor = characterColor
    }
    
    
}
