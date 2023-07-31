//
//  EnvironmentModel.swift
//  NoonMoaApt
//
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
        convertEnvironmentToViewData(isInputCurrentData: true, weather: currentWeather, time: currentTime, isThunder: currentIsThunder)
    }
    
    func getCurrentRawEnvironment() {
        var rawWeather: WeatherCondition // = 웨더킷에서 현재 날씨값 String 받아오기
        var rawSunriseTime: SunEvents // = 웨더킷에서 받아오기
        var rawSunsetTime: SunEvents // = 웨더킷에서 받아오기
        var rawTime: Date = Date() // = 현재 시간
        
        
    }
    
    func saveRawEnvironment()  {
    //attendanceModel.newAttendanceRecord(...)
    }
    
    //앱을 시작할 때 실행시키고, 달력을 켰을 때 접근한다.
    func fetchRecordedEnvironment(record: AttendanceRecord)  {
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
