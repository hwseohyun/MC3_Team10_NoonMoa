//
//  Weather.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI
import WeatherKit

//TODO: TimeViewModel을 여기에 통합시키는게 나을까?
class WeatherViewModel: ObservableObject {
    @Published var currentWeatherRaw: WeatherCondition = .clear // 실시간 날씨 raw data 불러오는 변수
    @Published var currentWeather: String = "clear"             // 실시간 날씨를 string 값으로 변환하는 변수
    @Published var savedSkyColor: LinearGradient = Color.sky.clearDay
    @Published var savedSkyImage: Image = Image.assets.weather.clearDay
    @StateObject var time: TimeViewModel = TimeViewModel()
}

extension WeatherViewModel {
    static let clear: String = "clear"
    static let cloudy: String = "cloudy"
    static let rainy: String = "rainy"
    static let snowy: String = "snowy"
    static let windy: String = "windy"
    static let thunder: String = "thunder"
}

extension WeatherViewModel {
    //TODO: 웨더킷으로부터 현재 날씨 받아와서 currentWeatherRaw에 넣을 것
    /*
    func getCurrentWeather(_ currentWeatherRaw: WeatherCondition) {
        switch self.currentWeatherRaw {
        case "clear123":
            currentWeather = "clear"
        default : break
        }
        */
    
    func getCurrentWeather() {
        switch currentWeatherRaw {
            case .clear, .hot, .mostlyClear:
            currentWeather = WeatherViewModel.clear
            case .blowingDust, .cloudy, .foggy, .haze, .hurricane, .mostlyCloudy, .partlyCloudy, .smoky:
                currentWeather = WeatherViewModel.cloudy
            case .rain, .heavyRain, .freezingRain, .sunShowers, .drizzle, .freezingDrizzle, .hail:
                currentWeather = WeatherViewModel.rainy
            case .blizzard, .snow, .sunFlurries, .heavySnow, .blowingSnow, .flurries, .sleet, .frigid, .wintryMix:
                currentWeather = WeatherViewModel.snowy
            case .breezy, .windy, .tropicalStorm:
                currentWeather = WeatherViewModel.windy
            case .isolatedThunderstorms, .scatteredThunderstorms, .strongStorms, .thunderstorms:
                currentWeather = WeatherViewModel.thunder
            @unknown default:
                currentWeather = WeatherViewModel.clear
        }
    }
    
    func updateWeather(with weather: WeatherCondition) { // 실시간 날씨 상황을 불러오는 함수
        currentWeatherRaw = weather
        getCurrentWeather() // Map the received weather condition to the weather classification system
    }
    
    func getColorFromCurrentWeather() {
    //TODO: db에서 string으로 날씨 받아서 self.currentWeather에 부여할 것
        
        switch self.currentWeather {
        case "clear": // 맑은 날
            switch time.currentTime {
            case "Sunrise":
                savedSkyColor = Color.sky.sunrise
                savedSkyImage = Image.assets.largeStamp.clearDay
            case "Morning", "Afternoon":
                savedSkyColor = Color.sky.clearDay
                savedSkyImage = Image.assets.largeStamp.clearDay
            case "Sunset":
                savedSkyColor = Color.sky.sunset
                savedSkyImage = Image.assets.largeStamp.clearDay
            case "Evening", "Night":
                savedSkyColor = Color.sky.clearNight
                savedSkyImage = Image.assets.largeStamp.clearNight
            default:
                break
            }
            
        case "cloudy": // 흐린 날
            switch time.currentTime {
            case "Sunrise":
                savedSkyColor = Color.sky.sunrise
                savedSkyImage = Image.assets.largeStamp.cloudyDay
            case "Morning", "Afternoon":
                savedSkyColor = Color.sky.cloudyDay
                savedSkyImage = Image.assets.largeStamp.cloudyDay
            case "Sunset":
                savedSkyColor = Color.sky.sunset
                savedSkyImage = Image.assets.largeStamp.cloudyDay
            case "Evening", "Night":
                savedSkyColor = Color.sky.clearNight
                savedSkyImage = Image.assets.largeStamp.cloudyNight
            default:
                break
            }
            
        case "rainy": // 비오는 날
            switch time.currentTime {
            case "Sunrise":
                savedSkyColor = Color.sky.rainyDay
                savedSkyImage = Image.assets.largeStamp.rainyDay
            case "Morning", "Afternoon":
                savedSkyColor = Color.sky.rainyDay
                savedSkyImage = Image.assets.largeStamp.rainyDay
            case "Sunset":
                savedSkyColor = Color.sky.rainyDay
                savedSkyImage = Image.assets.largeStamp.rainyDay
            case "Evening", "Night":
                savedSkyColor = Color.sky.rainyNight
                savedSkyImage = Image.assets.largeStamp.rainyDay
            default:
                break
            }
            
        case "snowy": // 눈오는 날
            switch time.currentTime {
            case "Sunrise":
                savedSkyColor = Color.sky.sunrise
                savedSkyImage = Image.assets.largeStamp.snowyDay
            case "Morning", "Afternoon":
                savedSkyColor = Color.sky.snowyDay
                savedSkyImage = Image.assets.largeStamp.snowyDay
            case "Sunset":
                savedSkyColor = Color.sky.sunset
                savedSkyImage = Image.assets.largeStamp.snowyDay
            case "Evening", "Night":
                savedSkyColor = Color.sky.snowyNight
                savedSkyImage = Image.assets.largeStamp.snowyNight
            default:
                break
            }
        case "thunder": // 번개 치는 날
            savedSkyColor = Color.sky.cloudyDay
            savedSkyImage = Image.assets.largeStamp.thunder
            default : break
        }
    }
}
