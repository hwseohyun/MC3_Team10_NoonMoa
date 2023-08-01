//
//  EnvironmentModel.swift
//  NoonMoaApt
//
<<<<<<< HEAD
//  Created by Seohyun Hwang on 2023/08/01.
//

import SwiftUI
import WeatherKit

class EnvironmentModel: ObservableObject {
    
    var rawWeather: WeatherCondition
    var rawTime: Date
    var rawtSunriseTime: Date
    var rawSunsetTime: Date

    @Published var currentWeather: String
    @Published var currentIsThunder: Bool
    @Published var currentTime: String
    @Published var currentLottieImageName: String
    @Published var currentColorOfSky: LinearGradient
    @Published var currentColorOfGround: LinearGradient
    @Published var currentBroadcastText: String
    @Published var currentStampLargeSkyImageName: String
    @Published var currentStampSmallSkyImageName: String
    @Published var currentStampBorderColor: Color


    var recordedRawWeather: WeatherCondition
    var recordedRawSunriseTime: Date
    var recordedRawSunsetTime: Date
    var recordedRawTime: Date

    var recordedWeather: String
    var recordedIsThunder: Bool
    var recordedTime: String

    var recordedLottieImageName: String
    var recordedColorOfSky: LinearGradient
    var recordedColorOfGround: LinearGradient
    var recordedBroadastText: String
    var recordedStampLargeSkyImageName: String
    var recordedStampSmallSkyImageName: String
    var recordedStampBorderColor: Color
    
    //앱을 시작할 때 실행시키며, 10분단위로 실행시킨다. 이 모델을 따르는 뷰는 자동으로 업데이트 된다.
    func getCurrentEnvironment() {
        getCurrentRawEnvironment()
        // convertRawEnvironmentToEnvironment(isInputCurrentData: true, weather: rawWeather, time: rawTime, sunrise: rawtSunriseTime, sunset: rawSunsetTime)
=======
//  Created by 최민규 on 2023/07/31.
//

import Foundation
import SwiftUI

class EnvironmentModel: ObservableObject {
    
    //rawData to be uploaded to the server
    var rawWeather: String = ""
    var rawTime: Date = Date()
    var rawSunriseTime: Date = Date()
    var rawSunsetTime: Date = Date()
    
    //rawData -> currentEnvironmentData
    @Published var currentWeather: String = "clear"
    @Published var currentIsWind: Bool = false
    @Published var currentIsThunder: Bool = false
    @Published var currentTime: String = "morning"
    
    //currentEnvironmentData -> currentViewData
    @Published var currentLottieImageName: String = Lottie.clearMorning
    @Published var currentColorOfSky: LinearGradient = LinearGradient.sky.clearMorning
    @Published var currentColorOfGround: LinearGradient = LinearGradient.ground.clearMorning
    @Published var currentBroadcastText: String = Text.broadcast.clearMorning
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
    var recordedBroadcastText: String = Text.broadcast.clearMorning
    var recordedStampLargeSkyImage: Image = Image.assets.stampLarge.clearMorning
    var recordedStampSmallSkyImage: Image = Image.assets.stampSmall.clearMorning
    var recordedStampBorderColor: Color = Color.stampBorder.clearMorning
    
    //MARK: --
   
    //앱을 시작할 때 실행시키며, 10분단위로 실행시킨다. 이 모델을 따르는 뷰는 자동으로 업데이트 된다.
    func getCurrentEnvironment() {
        getCurrentRawEnvironment()
        convertRawDataToEnvironment(isInputCurrentData: true, weather: rawWeather, time: rawTime, sunrise: rawSunriseTime, sunset: rawSunsetTime)
>>>>>>> 5bc046103b7d59dd69d7e9f3f2fb5314dd8b6c62
        convertEnvironmentToViewData(isInputCurrentData: true, weather: currentWeather, time: currentTime, isThunder: currentIsThunder)
        print("weather: \(currentWeather)")
        print("time: \(rawTime)")
        print("time: \(currentTime)")

    }
    
    func getCurrentRawEnvironment() {
<<<<<<< HEAD
        var rawWeather: WeatherCondition // = 웨더킷에서 현재 날씨값 String 받아오기
        var rawSunriseTime: SunEvents // = 웨더킷에서 받아오기
        var rawSunsetTime: SunEvents // = 웨더킷에서 받아오기
        var rawTime: Date = Date() // = 현재 시간
        
        
    }
    
    func saveRawEnvironment()  {
    //attendanceModel.newAttendanceRecord(...)
=======
        //웨더킷?
            rawWeather = "11"
            rawSunriseTime = Date()
            rawSunsetTime = Date()
            rawTime = Date()
    }
    
    func saveRawEnvironmentToAttendanceModel()  {
        //attendanceModel.newAttendanceRecord(...)
>>>>>>> 5bc046103b7d59dd69d7e9f3f2fb5314dd8b6c62
    }
    
    //앱을 시작할 때 실행시키고, 달력을 켰을 때 접근한다.
    func fetchRecordedEnvironment(record: AttendanceRecord)  {
<<<<<<< HEAD
    saveRecordedRawEnvironmentToEnvironmentModel(record: record)
    convertRawEnvironmentToEnvironment(isInputCurrentData: false, weather: recordedRawWeather, time: recordedRawTime, sunrise: recordedRawSunriseTime, sunset: recordedRawSunsetTime)
    convertEnvironmentToViewData(isInputCurrentData: false, weather: recordedWeather, time: recordedTime, isThunder: recordedIsThunder)
    }
    
    func saveRecordedRawEnvironmentToEnvironmentModel(record: AttendanceRecord) {
    recordedRawWeather = record.rawWeather
    recordedRawSunriseTime = record.rawSunriseTime
    recordedRawSunsetTime = record.rawSunsetTime
    recordedRawTime = record.rawTime
    }
    
    func convertRawDataToEnvironment(isInputCurrentData: Bool, weather: WeatherCondition, time: Date, sunrise: Date, sunset: Date) -> String {
        
        switch weather {
        case .clear, .hot, .mostlyClear: return "clear"
        case .blowingDust, .cloudy, .foggy, .haze, .hurricane, .mostlyCloudy, .partlyCloudy, .smoky: return "cloudy"
        case .rain, .heavyRain, .freezingRain, .sunShowers, .drizzle, .freezingDrizzle, .hail: return "rainy"
        case .blizzard, .snow, .sunFlurries, .heavySnow, .blowingSnow, .flurries, .sleet, .frigid, .wintryMix: return "snowy"
        case .breezy, .windy, .tropicalStorm: return "windy"
        default: return "clear"
        }
        
        switch weather {
        case: .isolatedThunderstorms, .scatteredThunderstorms, .strongStorms, .thunderstorms: return "true"
        case: “999”, “000”: return "true"
        default: "false"
        }
        
        let time =
        let t = getIntFromDate(time: time)
        let sunrise = getIntFromDate(time: sunrise)
        let sunset = getIntFromDate(time: sunset)
        switch t {
        case let t where t == sunrise:  return “sunrise”
        case let t where t == sunset:  return “sunset”
        case let t where (t >= 22) || (t >= 0 && t < 6):  return “night”
        case let t where t >= 6 && t < 12:  return “morning”
        case let t where t >= 12 && t < 18:  return “afternoon”
        case let t where t >= 18 && t < 22:  return “evening”
        }
        if isInputCurrentData {
            currentWeather = weather
            currentIsThunder = isThunder
            currentTime = time
        } else {
            recordedWeather = weather
            recordedIsThunder = isThunder
            recordedTime = time
        }
    }
    
    func convertEnvironmentToViewData(isInputCurrentData: Bool, weather: String, time: String, isThunder: Bool) {
        var viewData = [String: Any]()
         
        switch weather {
        case “clear”:
             switch time {
             case “morning”:
                 viewData = [“lottieImageName”: Lottie.clearDay,  “colorOfSky” = LinearGradiant.sky.clearDay, “colorOfGround”: LinearGradiant.ground.grassGreen, “broadcastText”: Text.broadcast.clearDay, “stampLargeSkyImageName”: Image.assets.stampLarge.clearDay, “stampSmallSkyImageName”: Image.assets.stampSmall.clearDay, “stampBorderColor”: Color.stampBorder.clearDay]

            case “Night”:
                 viewData = [“lottieImageName”: Lottie.clearNight,  “colorOfSky” = LinearGradiant.sky.clearNight, “colorOfGround”: LinearGradiant.ground.grassGreen,   “broadcastText”: Text.broadcast.clearNight, “stampLargeSkyImageName”: Image.assets.stampLarge.clearNight, “stampSmallSkyImageName”: Image.assets.stampSmall.clearNight, “stampBorderColor”: Color.stampBorder.clearNight]
             }
        case “cloudy”:
            switch time {
            case “morning”:
                viewData = [“lottieImageName”: Lottie.cloudyDay,  “colorOfSky” = LinearGradiant.sky.cloudyDay, “colorOfGround”: LinearGradiant.ground.grassGreen,   “broadcastText”: Text.broadcast.cloudyDay, “stampLargeSkyImageName”: Image.assets.stampLarge.cloudyDay, “stampSmallSkyImageName”: Image.assets.stampSmall.cloudyDay, “stampBorderColor”: Color.stampBorder.cloudyDay]
            }
            case “Night”:
               viewData = [“lottieImageName”: Lottie.cloudyNight,  “colorOfSky” = LinearGradiant.sky.cloudyNight, “colorOfGround”: LinearGradiant.ground.grassGreen,   “broadcastText”: Text.broadcast.cloudyNight, “stampLargeSkyImageName”: Image.assets.stampLarge.cloudyNight, “stampSmallSkyImageName”: Image.assets.stampSmall.cloudyNight, “stampBorderColor”: Color.stampBorder.cloudyNight]
        }
    }

    if isInputCurrentData {
        currentLottieImageName = viewData[“lottieImageName”]
        currentColorOfSky = viewData[“colorOfSky”]
        currentColorOfGround = viewData[“colorOfGround”]
        currentBroadcastText = viewData[“broadcastText”]

        currentStampLargeSkyImageName = viewData[“stampLargeSkyImageName”]
        currentStampSmallSkyImageName = viewData[“stampSmallSkyImageName”]
        currentStampBorderColor = viewData[“stampBorderColor”]
    } else {
        recordedLottieImageName = viewData[“recordedLottieImageName”]
        recordedColorOfSky = viewData[“recordedColorOfSky”]
        recordedColorOfGround = viewData[“recordedColorOfGround”]
        recordedBroadcastText = viewData[“recordedBroadcastText”]

        recordedStampLargeSkyImageName = viewData[“recordedStampLargeSkyImageName”]
        recordedStampSmallSkyImageName = viewData[“recordedStampSmallSkyImageName”]
        recordedStampBorderColor = viewData[“recordedStampBorderColor”]
    }
}
=======
        saveRecordedRawEnvironmentToEnvironmentModel(record: record)
        convertRawDataToEnvironment(isInputCurrentData: false, weather: recordedRawWeather, time: recordedRawTime, sunrise: recordedRawSunriseTime, sunset: recordedRawSunsetTime)
        convertEnvironmentToViewData(isInputCurrentData: false, weather: recordedWeather, time: recordedTime, isThunder: recordedIsThunder)
    }
    
    func saveRecordedRawEnvironmentToEnvironmentModel(record: AttendanceRecord) {
        recordedRawWeather = record.rawWeather
        recordedRawSunriseTime = record.rawtSunriseTime
        recordedRawSunsetTime = record.rawSunsetTime
        recordedRawTime = record.rawTime
    }
    
    
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
//        case let t where t == sunrise: environmentTime = "sunrise"
//        case let t where t == sunset: environmentTime = "sunset"
        case let t where (t >= 22) || (t >= 0 && t < 6): environmentTime = "night"
        case let t where t >= 6 && t < 12: environmentTime = "morning"
        case let t where t >= 12 && t < 18: environmentTime = "afternoon"
        case let t where t >= 18 && t < 22: environmentTime = "evening"
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
    
    func convertEnvironmentToViewData(isInputCurrentData: Bool, weather: String, time: String, isThunder: Bool) {
        var viewData = [String: Any]()
        switch weather {
        case "clear":
            switch time {
            case "sunrise":
                viewData = ["lottieImageName": Lottie.clearSunrise,
                            "colorOfSky": LinearGradient.sky.clearSunrise,
                            "colorOfGround": LinearGradient.ground.clearSunrise,
                            "broadcastText": Text.broadcast.clearSunrise,
                            "stampLargeSkyImage": Image.assets.stampLarge.clearSunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearSunrise,
                            "stampBorderColor": Color.stampBorder.clearSunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.clearMorning,
                            "colorOfSky": LinearGradient.sky.clearMorning,
                            "colorOfGround": LinearGradient.ground.clearMorning,
                            "broadcastText": Text.broadcast.clearMorning,
                            "stampLargeSkyImage": Image.assets.stampLarge.clearMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearMorning,
                            "stampBorderColor": Color.stampBorder.clearMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.clearAfternoon,
                            "colorOfSky": LinearGradient.sky.clearAfternoon,
                            "colorOfGround": LinearGradient.ground.clearAfternoon,
                            "broadcastText": Text.broadcast.clearAfternoon,
                            "stampLargeSkyImage": Image.assets.stampLarge.clearAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearAfternoon,
                            "stampBorderColor": Color.stampBorder.clearAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.clearSunset,
                            "colorOfSky": LinearGradient.sky.clearSunset,
                            "colorOfGround": LinearGradient.ground.clearSunset,
                            "broadcastText": Text.broadcast.clearSunset,
                            "stampLargeSkyImage": Image.assets.stampLarge.clearSunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearSunset,
                            "stampBorderColor": Color.stampBorder.clearSunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.clearEvening,
                            "colorOfSky": LinearGradient.sky.clearEvening,
                            "colorOfGround": LinearGradient.ground.clearEvening,
                            "broadcastText": Text.broadcast.clearEvening,
                            "stampLargeSkyImage": Image.assets.stampLarge.clearEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.clearEvening,
                            "stampBorderColor": Color.stampBorder.clearEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.clearNight,
                            "colorOfSky": LinearGradient.sky.clearNight,
                            "colorOfGround": LinearGradient.ground.clearNight,
                            "broadcastText": Text.broadcast.clearNight,
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
                            "broadcastText": Text.broadcast.cloudySunrise,
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudySunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudySunrise,
                            "stampBorderColor": Color.stampBorder.cloudySunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.cloudyMorning,
                            "colorOfSky": LinearGradient.sky.cloudyMorning,
                            "colorOfGround": LinearGradient.ground.cloudyMorning,
                            "broadcastText": Text.broadcast.cloudyMorning,
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudyMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyMorning,
                            "stampBorderColor": Color.stampBorder.cloudyMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.cloudyAfternoon,
                            "colorOfSky": LinearGradient.sky.cloudyAfternoon,
                            "colorOfGround": LinearGradient.ground.cloudyAfternoon,
                            "broadcastText": Text.broadcast.cloudyAfternoon,
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudyAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyAfternoon,
                            "stampBorderColor": Color.stampBorder.cloudyAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.cloudySunset,
                            "colorOfSky": LinearGradient.sky.cloudySunset,
                            "colorOfGround": LinearGradient.ground.cloudySunset,
                            "broadcastText": Text.broadcast.cloudySunset,
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudySunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudySunset,
                            "stampBorderColor": Color.stampBorder.cloudySunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.cloudyEvening,
                            "colorOfSky": LinearGradient.sky.cloudyEvening,
                            "colorOfGround": LinearGradient.ground.cloudyEvening,
                            "broadcastText": Text.broadcast.cloudyEvening,
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudyEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.cloudyEvening,
                            "stampBorderColor": Color.stampBorder.cloudyEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.cloudyNight,
                            "colorOfSky": LinearGradient.sky.cloudyNight,
                            "colorOfGround": LinearGradient.ground.cloudyNight,
                            "broadcastText": Text.broadcast.cloudyNight,
                            "stampLargeSkyImage": Image.assets.stampLarge.cloudyNight,
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
                            "broadcastText": Text.broadcast.rainySunrise,
                            "stampLargeSkyImage": Image.assets.stampLarge.rainySunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainySunrise,
                            "stampBorderColor": Color.stampBorder.rainySunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.rainyMorning,
                            "colorOfSky": LinearGradient.sky.rainyMorning,
                            "colorOfGround": LinearGradient.ground.rainyMorning,
                            "broadcastText": Text.broadcast.rainyMorning,
                            "stampLargeSkyImage": Image.assets.stampLarge.rainyMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyMorning,
                            "stampBorderColor": Color.stampBorder.rainyMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.rainyAfternoon,
                            "colorOfSky": LinearGradient.sky.rainyAfternoon,
                            "colorOfGround": LinearGradient.ground.rainyAfternoon,
                            "broadcastText": Text.broadcast.rainyAfternoon,
                            "stampLargeSkyImage": Image.assets.stampLarge.rainyAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyAfternoon,
                            "stampBorderColor": Color.stampBorder.rainyAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.rainySunset,
                            "colorOfSky": LinearGradient.sky.rainySunset,
                            "colorOfGround": LinearGradient.ground.rainySunset,
                            "broadcastText": Text.broadcast.rainySunset,
                            "stampLargeSkyImage": Image.assets.stampLarge.rainySunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainySunset,
                            "stampBorderColor": Color.stampBorder.rainySunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.rainyEvening,
                            "colorOfSky": LinearGradient.sky.rainyEvening,
                            "colorOfGround": LinearGradient.ground.rainyEvening,
                            "broadcastText": Text.broadcast.rainyEvening,
                            "stampLargeSkyImage": Image.assets.stampLarge.rainyEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.rainyEvening,
                            "stampBorderColor": Color.stampBorder.rainyEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.rainyNight,
                            "colorOfSky": LinearGradient.sky.rainyNight,
                            "colorOfGround": LinearGradient.ground.rainyNight,
                            "broadcastText": Text.broadcast.rainyNight,
                            "stampLargeSkyImage": Image.assets.stampLarge.rainyNight,
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
                            "broadcastText": Text.broadcast.snowySunrise,
                            "stampLargeSkyImage": Image.assets.stampLarge.snowySunrise,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowySunrise,
                            "stampBorderColor": Color.stampBorder.snowySunrise]
                
            case "morning":
                viewData = ["lottieImageName": Lottie.snowyMorning,
                            "colorOfSky": LinearGradient.sky.snowyMorning,
                            "colorOfGround": LinearGradient.ground.snowyMorning,
                            "broadcastText": Text.broadcast.snowyMorning,
                            "stampLargeSkyImage": Image.assets.stampLarge.snowyMorning,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyMorning,
                            "stampBorderColor": Color.stampBorder.snowyMorning]
                
            case "afternoon":
                viewData = ["lottieImageName": Lottie.snowyAfternoon,
                            "colorOfSky": LinearGradient.sky.snowyAfternoon,
                            "colorOfGround": LinearGradient.ground.snowyAfternoon,
                            "broadcastText": Text.broadcast.snowyAfternoon,
                            "stampLargeSkyImage": Image.assets.stampLarge.snowyAfternoon,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyAfternoon,
                            "stampBorderColor": Color.stampBorder.snowyAfternoon]
                
            case "sunset":
                viewData = ["lottieImageName": Lottie.snowySunset,
                            "colorOfSky": LinearGradient.sky.snowySunset,
                            "colorOfGround": LinearGradient.ground.snowySunset,
                            "broadcastText": Text.broadcast.snowySunset,
                            "stampLargeSkyImage": Image.assets.stampLarge.snowySunset,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowySunset,
                            "stampBorderColor": Color.stampBorder.snowySunset]
                
            case "evening":
                viewData = ["lottieImageName": Lottie.snowyEvening,
                            "colorOfSky": LinearGradient.sky.snowyEvening,
                            "colorOfGround": LinearGradient.ground.snowyEvening,
                            "broadcastText": Text.broadcast.snowyEvening,
                            "stampLargeSkyImage": Image.assets.stampLarge.snowyEvening,
                            "stampSmallSkyImage": Image.assets.stampSmall.snowyEvening,
                            "stampBorderColor": Color.stampBorder.snowyEvening]
                
            case "night":
                viewData = ["lottieImageName": Lottie.snowyNight,
                            "colorOfSky": LinearGradient.sky.snowyNight,
                            "colorOfGround": LinearGradient.ground.snowyNight,
                            "broadcastText": Text.broadcast.snowyNight,
                            "stampLargeSkyImage": Image.assets.stampLarge.snowyNight,
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
            currentBroadcastText = viewData["broadcastText"] as! String
            
            currentStampLargeSkyImage = viewData["stampLargeSkyImage"] as! Image
            currentStampSmallSkyImage = viewData["stampSmallSkyImage"] as! Image
            currentStampBorderColor = viewData["stampBorderColor"] as! Color
        } else {
            recordedLottieImageName = viewData["recordedLottieImageName"] as! String
            recordedColorOfSky = viewData["recordedColorOfSky"] as! LinearGradient
            recordedColorOfGround = viewData["recordedColorOfGround"] as! LinearGradient
            recordedBroadcastText = viewData["recordedBroadcastText"] as! String
            
            recordedStampLargeSkyImage = viewData["recordedStampLargeSkyImageName"] as! Image
            recordedStampSmallSkyImage = viewData["recordedStampSmallSkyImageName"] as! Image
            recordedStampBorderColor = viewData["recordedStampBorderColor"] as! Color
        }
    }
}

>>>>>>> 5bc046103b7d59dd69d7e9f3f2fb5314dd8b6c62
