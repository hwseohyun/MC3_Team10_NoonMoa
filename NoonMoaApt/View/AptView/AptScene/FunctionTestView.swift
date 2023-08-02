//
//  FunctionTestView.swift
//  MC3
//
//  Created by 최민규 on 2023/07/17.
//

import SwiftUI

struct FunctionTestView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var environmentModel: EnvironmentModel
    @EnvironmentObject var weatherKitManager: WeatherKitManager
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var indexTime: Int = 0
    @State private var indexWeather: Int = 0
    @Binding var buttonText: String
    
    var body: some View { 
        VStack(alignment: .leading) {
            Spacer().frame(height: 48)
            HStack(spacing: 8) {
                Button(action: {
                    let array = ["sunrise", "morning", "afternoon", "sunset", "evening", "night"]
                    indexTime = (indexTime + 7) % 6
                    environmentModel.currentTime = array[indexTime]
                    environmentModel.convertEnvironmentToViewData(isInputCurrentData: true, weather: environmentModel.currentWeather, time: environmentModel.currentTime, isThunder: environmentModel.currentIsThunder)
                    print(indexTime)
                    print(environmentModel.currentTime)
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Day/Night")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                Button(action: {
                    let array = ["clear", "cloudy", "rainy", "snowy"]
                    indexWeather = (indexWeather + 5) % 4
                    environmentModel.currentWeather = array[indexWeather]
                    print(indexWeather)
                    print(environmentModel.currentWeather)
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Weather\nShuffle")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(width: 80, height: 48)
                    .overlay(
                        Text(buttonText)
                            .foregroundColor(.black)
                            .font(.caption)
                    )
                    .opacity(0.1)
                Button(action: {
                    EyeViewController().resetFaceAnchor()
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Reset\nFace")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 8) {
                Button(action: {
                    viewRouter.currentView = .attendance
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Attendance\nView")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                Button(action: {
                    weatherKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                        environmentModel.rawWeather = weatherKitManager.condition
                    environmentModel.getCurrentEnvironment()
                    print(environmentModel.rawWeather)
                    print(environmentModel.currentTime)
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("Get\nWeather")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
                Button(action: {
                    viewRouter.currentView = .onBoarding
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: 80, height: 48)
                        .overlay(
                            Text("OnBoarding\nView")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .opacity(0.1)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct FunctionTestView_Previews: PreviewProvider {
    @State static var buttonText: String = ""
    
    static var previews: some View {
        FunctionTestView(buttonText: $buttonText)
            .environmentObject(ViewRouter())
            .environmentObject(EnvironmentModel())
    }
}
