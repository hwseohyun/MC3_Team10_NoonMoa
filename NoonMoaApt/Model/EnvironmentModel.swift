//
//  EnvironmentModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation
import SwiftUI

class EnvironmentModel: ObservableObject {
    
    //rawData to be uploaded e server
    var rawWeather: String = ""
    var rawTime: Date = Date()
    var rawSunriseTime: Date {
        // Calculate and return the sunrise time (e.g., 7:28 PM)
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 05
        dateComponents.minute = 30
        return calendar.date(bySettingHour: dateComponents.hour!, minute: dateComponents.minute!, second: 0, of: Date())!
    }
    var rawSunsetTime: Date {
        // Calculate and return the sunrise time (e.g., 7:28 PM)
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 28
        return calendar.date(bySettingHour: dateComponents.hour!, minute: dateComponents.minute!, second: 0, of: Date())!
    }

    
    //rawData -> currentEnvironmentData
    @Published var currentWeather: String = "clear"
    @Published var currentIsWind: Bool = false
    @Published var currentIsThunder: Bool = false
    @Published var currentTime: String = "morning"
    
    //currentEnvironmentData -> currentViewData
    @Published var currentLottieImageName: String = Lottie.clearMorning
    @Published var currentColorOfSky: LinearGradient = LinearGradient.sky.clearMorning
    @Published var currentColorOfGround: LinearGradient = LinearGradient.ground.clearMorning
    @Published var currentBroadcastAttendanceIncompleteTitle: String = Text.broadcast.attendanceIncompleteTitle.clearMorning
    @Published var currentBroadcastAttendanceIncompleteBody: String = Text.broadcast.attendanceIncompleteBody.clearMorning
    @Published var currentBroadcastAttendanceCompletedTitle: String = Text.broadcast.attendanceCompletedTitle.clearMorning
    @Published var currentBroadcastAttendanceCompletedBody: String = Text.broadcast.attendanceCompletedBody.clearMorning
    @Published var currentBroadcastAnnounce: String = (Text.broadcast.announce.randomElement() ?? "")
    @Published var currentStampLargeSkyImage: Image = Image.assets.stampLarge.clearMorning
    @Published var currentStampSmallSkyImage: Image = Image.assets.stampSmall.clearMorning
    @Published var currentStampBorderColor: Color = Color.stampBorder.clearMorning
    
    //recordedRawData from the server
    var recordedRawWeather: String = ""
    var recordedRawSunriseTime: Date = Date()
    var recordedRawSunsetTime: Date = Date()
    var recordedRawTime: Date = Date()
    
    //recordedRawData -> recordedEnvironmentData
    var recordedWeather: String = "clear"
    var recordedIsWind: Bool = false
    var recordedIsThunder: Bool = false
    var recordedTime: String = "morning"
    
    //recordedEnvironmentData -> recordedViewData
    var recordedLottieImageName: String = Lottie.clearMorning
    var recordedColorOfSky: LinearGradient = LinearGradient.sky.clearMorning
    var recordedColorOfGround: LinearGradient = LinearGradient.ground.clearMorning
    var recordedStampLargeSkyImage: Image = Image.assets.stampLarge.clearMorning
    var recordedStampSmallSkyImage: Image = Image.assets.stampSmall.clearMorning
    var recordedStampBorderColor: Color = Color.stampBorder.clearMorning
    
   
    // MARK: - 업로드 -
    
    //앱을 시작할 때 실행시키며, 10분단위로 실행시킨다. 이 모델을 따르는 뷰는 자동으로 업데이트 된다.
    func getCurrentEnvironment() {
//        getCurrentRawEnvironment()
//        convertRawDataToEnvironment(isInputCurrentData: true, weather: rawWeather, time: rawTime, sunrise: rawSunriseTime, sunset: rawSunsetTime)
        convertEnvironmentToViewData(isInputCurrentData: true, weather: currentWeather, time: currentTime, isThunder: currentIsThunder)
        print("weather: \(currentWeather)")
        print("time: \(rawTime)")
        print("time: \(currentTime)")
        print("lottie: \(currentLottieImageName)")
    }
    
    // WeatherKit에서 데이터를 받아와서, raw data 업데이트
    func getCurrentRawEnvironment() {
        //웨더킷?
            rawWeather = "2"
//            rawSunriseTime = Date()
//            rawSunsetTime = Date()
            rawTime = Date()
    }
    
    // 서버에 저장하기 위해, Attendance 모델을 업데이트 할 때 사용
    // attendanceModel.newAttendanceRecord에 접근하여, Environment와 관련된 recordedRaw...변수를 업데이트 해주는 방식
    // 이후 newAttendanceRecord는 CharacterModel로도 업데이트 받은 뒤에, 서버에 업로드
//        func saveRawEnvironmentToAttendanceModel()  {
//        //attendanceModel.newAttendanceRecord(...)
//    }
    
    func saveRawEnvironmentToAttendanceModel(newAttendanceRecord: inout AttendanceRecord?) {
        // Update recorded environment-related data properties in newAttendanceRecord with the raw environment data from EnvironmentModel
        if newAttendanceRecord == nil {
            rawWeather = "11"
            rawSunriseTime = Date()
            rawSunsetTime = Date()
            rawTime = Date()
            return
        }
        newAttendanceRecord?.rawWeather = rawWeather
        newAttendanceRecord?.rawTime = rawTime
        newAttendanceRecord?.rawSunriseTime = rawSunriseTime
        newAttendanceRecord?.rawSunsetTime = rawSunsetTime
        // Update other recorded environment-related properties as needed
    }


    
    // MARK: - 다운로드 -
    
    //앱을 시작할 때 실행시키고, 달력을 켰을 때 접근한다.
    func fetchRecordedEnvironment(record: AttendanceRecord)  {
        print("EnvironmentModel | fetchRecordedEnvironment arrived")
        saveRecordedRawEnvironmentToEnvironmentModel(record: record)
        convertRawDataToEnvironment(isInputCurrentData: false, weather: recordedRawWeather, time: recordedRawTime, sunrise: recordedRawSunriseTime, sunset: recordedRawSunsetTime)
        convertEnvironmentToViewData(isInputCurrentData: false, weather: recordedWeather, time: recordedTime, isThunder: recordedIsThunder)
    }
    
    // 저장된 recordedRaw... 변수를 받아와서 EnvironmentModel을 업데이트
    func saveRecordedRawEnvironmentToEnvironmentModel(record: AttendanceRecord) {
        print("EnvironmentModel | saveRecordedRawEnvironmentToEnvironmentModel arrived")
        recordedRawWeather = record.rawWeather
        recordedRawSunriseTime = record.rawSunriseTime
        recordedRawSunsetTime = record.rawSunsetTime
        recordedRawTime = record.rawTime
    }
    
    
    // MARK: - 업로드 & 다운로드 -
    
    // W[WeatherKit으로부터 받아온 raw data or 서버로부터 받아온 recordedRaw]를 Environment로 중간 변환
    func convertRawDataToEnvironment(isInputCurrentData: Bool, weather: String, time: Date, sunrise: Date, sunset: Date) {
        
        let environmentWeather: String
        switch weather {
        case "1", "2", "3": environmentWeather = "clear"
        case "4", "5", "6", "7": environmentWeather = "cloudy"
        case "8", "9", "10": environmentWeather = "rainy"
        case "11", "12", "13": environmentWeather = "snowy"
        default: environmentWeather = ""
        }
        
        let environmentIsWind: Bool
        switch weather {
        case "1", "2", "3": environmentIsWind = true
        case "4", "5", "6", "7": environmentIsWind = false
        case "8", "9", "10": environmentIsWind = false
        case "11", "12", "13": environmentIsWind = false
        default: environmentIsWind = false
        }
        
        let environmentIsThunder: Bool
        switch weather {
        case "1", "2", "3": environmentIsThunder = false
        case "4", "5", "6", "7": environmentIsThunder = true
        case "8", "9", "10": environmentIsThunder = false
        case "11", "12", "13": environmentIsThunder = true
        default: environmentIsThunder = false
        }
        
        let environmentTime: String
        let t = getHourFromDate(time: time)
        let sunrise = getHourFromDate(time: sunrise)
        let sunset = getHourFromDate(time: sunset)
        switch t {
        case let t where t == sunrise: environmentTime = "sunrise"
        case let t where t == sunset: environmentTime = "sunset"
        case let t where (t >= 22) || (t >= 0 && t < 6): environmentTime = "night"
        case let t where t >= 6 && t < 12: environmentTime = "morning"
        case let t where t >= 12 && t < 19: environmentTime = "afternoon"
        case let t where t >= 19 && t < 22: environmentTime = "evening"
        default: environmentTime = ""
        }
        if isInputCurrentData {
            currentWeather = environmentWeather
            currentIsWind = environmentIsWind
            currentIsThunder = environmentIsThunder
            currentTime = environmentTime
        } else {
            recordedWeather = environmentWeather
            recordedIsWind = environmentIsWind
            recordedIsThunder = environmentIsThunder
            recordedTime = environmentTime
        }
    }
    
    func getHourFromDate(time: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        return hour
    }
    
    // [WeatherKit으로부터 받아온 raw data or 서버로부터 받아온 recordedRaw]를 변환한 Environment를, View에서 사용할 수 있는 ViewData로 변환
    func convertEnvironmentToViewData(isInputCurrentData: Bool, weather: String, time: String, isThunder: Bool) {
        var viewData = [String: Any]()
        switch weather {
        case "clear":
            switch time {
            case "sunrise":
                viewData = ["lottieImageName": Lottie.clearSunrise,
                            "colorOfSky": LinearGradient.sky.clearSunrise,
                            "colorOfGround": LinearGradient.ground.clearSunrise,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.clearSunrise,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.clearSunrise,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.clearSunrise,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.clearSunrise,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.clearSunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearSunrise,
                            "stampBorderColor": Color.stampBorder.clearSunrise]
           
            case "morning":
                viewData = ["lottieImageName": Lottie.clearMorning,
                            "colorOfSky": LinearGradient.sky.clearMorning,
                            "colorOfGround": LinearGradient.ground.clearMorning,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.clearMorning,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.clearMorning,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.clearMorning,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.clearMorning,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.clearMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearMorning,
                            "stampBorderColor": Color.stampBorder.clearMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.clearAfternoon,
                            "colorOfSky": LinearGradient.sky.clearAfternoon,
                            "colorOfGround": LinearGradient.ground.clearAfternoon,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.clearAfternoon,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.clearAfternoon,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.clearAfternoon,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.clearAfternoon,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.clearAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearAfternoon,
                            "stampBorderColor": Color.stampBorder.clearAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.clearSunset,
                            "colorOfSky": LinearGradient.sky.clearSunset,
                            "colorOfGround": LinearGradient.ground.clearSunset,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.clearSunset,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.clearSunset,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.clearSunset,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.clearSunset,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.clearSunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearSunset,
                            "stampBorderColor": Color.stampBorder.clearSunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.clearEvening,
                            "colorOfSky": LinearGradient.sky.clearEvening,
                            "colorOfGround": LinearGradient.ground.clearEvening,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.clearEvening,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.clearEvening,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.clearEvening,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.clearEvening,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.clearEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearEvening,
                            "stampBorderColor": Color.stampBorder.clearEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.clearNight,
                            "colorOfSky": LinearGradient.sky.clearNight,
                            "colorOfGround": LinearGradient.ground.clearNight,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.clearNight,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.clearNight,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.clearNight,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.clearNight,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.clearNight,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearNight,
                            "stampBorderColor": Color.stampBorder.clearNight]
            default: viewData = [:]
            }
            
        case "cloudy":
            switch time {
            case "sunrise":
                viewData = ["lottieImageName": Lottie.cloudySunrise,
                            "colorOfSky": LinearGradient.sky.cloudySunrise,
                            "colorOfGround": LinearGradient.ground.cloudySunrise,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.cloudySunrise,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.cloudySunrise,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.cloudySunrise,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.cloudySunrise,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudySunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudySunrise,
                            "stampBorderColor": Color.stampBorder.cloudySunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.cloudyMorning,
                            "colorOfSky": LinearGradient.sky.cloudyMorning,
                            "colorOfGround": LinearGradient.ground.cloudyMorning,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.cloudyMorning,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.cloudyMorning,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.cloudyMorning,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.cloudyMorning,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudyMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyMorning,
                            "stampBorderColor": Color.stampBorder.cloudyMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.cloudyAfternoon,
                            "colorOfSky": LinearGradient.sky.cloudyAfternoon,
                            "colorOfGround": LinearGradient.ground.cloudyAfternoon,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.cloudyAfternoon,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.cloudyAfternoon,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.cloudyAfternoon,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.cloudyAfternoon,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                                "stampLargeSkyImage": Image.assets.stampLarge.cloudyAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyAfternoon,
                            "stampBorderColor": Color.stampBorder.cloudyAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.cloudySunset,
                            "colorOfSky": LinearGradient.sky.cloudySunset,
                            "colorOfGround": LinearGradient.ground.cloudySunset,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.cloudySunset,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.cloudySunset,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.cloudySunset,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.cloudySunset,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                                "stampLargeSkyImage": Image.assets.stampLarge.cloudySunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudySunset,
                            "stampBorderColor": Color.stampBorder.cloudySunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.cloudyEvening,
                            "colorOfSky": LinearGradient.sky.cloudyEvening,
                            "colorOfGround": LinearGradient.ground.cloudyEvening,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.cloudyEvening,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.cloudyEvening,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.cloudyEvening,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.cloudyEvening,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                                "stampLargeSkyImage": Image.assets.stampLarge.cloudyEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyEvening,
                            "stampBorderColor": Color.stampBorder.cloudyEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.cloudyNight,
                            "colorOfSky": LinearGradient.sky.cloudyNight,
                            "colorOfGround": LinearGradient.ground.cloudyNight,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.cloudyNight,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.cloudyNight,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.cloudyNight,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.cloudyNight,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                                "stampLargeSkyImage": Image.assets.stampLarge.cloudyNight,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyNight,
                            "stampBorderColor": Color.stampBorder.cloudyNight]
            default: viewData = [:]
            }
            
        case "rainy":
            switch time {
            case "sunrise":
                viewData = ["lottieImageName": Lottie.rainySunrise,
                            "colorOfSky": LinearGradient.sky.rainySunrise,
                            "colorOfGround": LinearGradient.ground.rainySunrise,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.rainySunrise,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.rainySunrise,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.rainySunrise,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.rainySunrise,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                                "stampLargeSkyImage": Image.assets.stampLarge.rainySunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainySunrise,
                            "stampBorderColor": Color.stampBorder.rainySunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.rainyMorning,
                            "colorOfSky": LinearGradient.sky.rainyMorning,
                            "colorOfGround": LinearGradient.ground.rainyMorning,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.rainyMorning,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.rainyMorning,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.rainyMorning,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.rainyMorning,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                       "stampLargeSkyImage": Image.assets.stampLarge.rainyMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyMorning,
                            "stampBorderColor": Color.stampBorder.rainyMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.rainyAfternoon,
                            "colorOfSky": LinearGradient.sky.rainyAfternoon,
                            "colorOfGround": LinearGradient.ground.rainyAfternoon,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.rainyAfternoon,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.rainyAfternoon,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.rainyAfternoon,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.rainyAfternoon,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                       "stampLargeSkyImage": Image.assets.stampLarge.rainyAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyAfternoon,
                            "stampBorderColor": Color.stampBorder.rainyAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.rainySunset,
                            "colorOfSky": LinearGradient.sky.rainySunset,
                            "colorOfGround": LinearGradient.ground.rainySunset,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.rainySunset,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.rainySunset,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.rainySunset,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.rainySunset,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                       "stampLargeSkyImage": Image.assets.stampLarge.rainySunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainySunset,
                            "stampBorderColor": Color.stampBorder.rainySunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.rainyEvening,
                            "colorOfSky": LinearGradient.sky.rainyEvening,
                            "colorOfGround": LinearGradient.ground.rainyEvening,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.rainyEvening,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.rainyEvening,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.rainyEvening,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.rainyEvening,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                       "stampLargeSkyImage": Image.assets.stampLarge.rainyEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyEvening,
                            "stampBorderColor": Color.stampBorder.rainyEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.rainyNight,
                            "colorOfSky": LinearGradient.sky.rainyNight,
                            "colorOfGround": LinearGradient.ground.rainyNight,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.rainyNight,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.rainyNight,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.rainyNight,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.rainyNight,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                       "stampLargeSkyImage": Image.assets.stampLarge.rainyNight,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyNight,
                            "stampBorderColor": Color.stampBorder.rainyNight]
            default: viewData = [:]
            }
            
        case "snowy":
            switch time {
            case "sunrise":
                viewData = ["lottieImageName": Lottie.snowySunrise,
                            "colorOfSky": LinearGradient.sky.snowySunrise,
                            "colorOfGround": LinearGradient.ground.snowySunrise,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.snowySunrise,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.snowySunrise,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.snowySunrise,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.snowySunrise,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                       "stampLargeSkyImage": Image.assets.stampLarge.snowySunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowySunrise,
                            "stampBorderColor": Color.stampBorder.snowySunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.snowyMorning,
                            "colorOfSky": LinearGradient.sky.snowyMorning,
                            "colorOfGround": LinearGradient.ground.snowyMorning,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.snowyMorning,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.snowyMorning,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.snowyMorning,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.snowyMorning,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                      "stampLargeSkyImage": Image.assets.stampLarge.snowyMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyMorning,
                            "stampBorderColor": Color.stampBorder.snowyMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.snowyAfternoon,
                            "colorOfSky": LinearGradient.sky.snowyAfternoon,
                            "colorOfGround": LinearGradient.ground.snowyAfternoon,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.snowyAfternoon,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.snowyAfternoon,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.snowyAfternoon,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.snowyAfternoon,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                      "stampLargeSkyImage": Image.assets.stampLarge.snowyAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyAfternoon,
                            "stampBorderColor": Color.stampBorder.snowyAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.snowySunset,
                            "colorOfSky": LinearGradient.sky.snowySunset,
                            "colorOfGround": LinearGradient.ground.snowySunset,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.snowySunset,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.snowySunset,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.snowySunset,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.snowySunset,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                      "stampLargeSkyImage": Image.assets.stampLarge.snowySunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowySunset,
                            "stampBorderColor": Color.stampBorder.snowySunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.snowyEvening,
                            "colorOfSky": LinearGradient.sky.snowyEvening,
                            "colorOfGround": LinearGradient.ground.snowyEvening,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.snowyEvening,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.snowyEvening,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.snowyEvening,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.snowyEvening,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                      "stampLargeSkyImage": Image.assets.stampLarge.snowyEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyEvening,
                            "stampBorderColor": Color.stampBorder.snowyEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.snowyNight,
                            "colorOfSky": LinearGradient.sky.snowyNight,
                            "colorOfGround": LinearGradient.ground.snowyNight,
                            "currentBroadcastAttendanceIncompleteTitle": Text.broadcast.attendanceIncompleteTitle.snowyNight,
                            "currentBroadcastAttendanceIncompleteBody": Text.broadcast.attendanceIncompleteBody.snowyNight,
                            "currentBroadcastAttendanceCompletedTitle": Text.broadcast.attendanceCompletedTitle.snowyNight,
                            "currentBroadcastAttendanceCompletedBody": Text.broadcast.attendanceCompletedBody.snowyNight,
                            "currentBroadcastAnnounce": (Text.broadcast.announce.randomElement() ?? ""),                                      "stampLargeSkyImage": Image.assets.stampLarge.snowyNight,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyNight,
                            "stampBorderColor": Color.stampBorder.snowyNight]
            default: viewData = [:]
            }
        default: viewData = [:]
        }
        
        if isInputCurrentData {
            currentLottieImageName = viewData["lottieImageName"] as! String
            currentColorOfSky = viewData["colorOfSky"] as! LinearGradient
            currentColorOfGround = viewData["colorOfGround"] as! LinearGradient
            currentBroadcastAttendanceIncompleteTitle = viewData["currentBroadcastAttendanceIncompleteTitle"] as! String
            currentBroadcastAttendanceIncompleteBody = viewData["currentBroadcastAttendanceIncompleteBody"] as! String
            currentBroadcastAttendanceCompletedTitle = viewData["currentBroadcastAttendanceCompletedTitle"] as! String
            currentBroadcastAttendanceCompletedBody = viewData["currentBroadcastAttendanceCompletedBody"] as! String
            currentBroadcastAnnounce = viewData["currentBroadcastAnnounce"] as! String
            currentStampLargeSkyImage = viewData["stampLargeSkyImage"] as! Image
            currentStampSmallSkyImage = viewData["stampSmallSkyImage"] as! Image
            currentStampBorderColor = viewData["stampBorderColor"] as! Color
        } else {
            recordedLottieImageName = viewData["recordedLottieImageName"] as! String
            recordedColorOfSky = viewData["recordedColorOfSky"] as! LinearGradient
            recordedColorOfGround = viewData["recordedColorOfGround"] as! LinearGradient
            recordedStampLargeSkyImage = viewData["recordedStampLargeSkyImageName"] as! Image
            recordedStampSmallSkyImage = viewData["recordedStampSmallSkyImageName"] as! Image
            recordedStampBorderColor = viewData["recordedStampBorderColor"] as! Color
        }
    }
}

