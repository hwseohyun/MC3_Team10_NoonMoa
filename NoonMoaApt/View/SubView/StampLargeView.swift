//
//  StampLargeView.swift
//  MC3
//
//  Created by Seohyun Hwang on 2023/07/20.
//

import SwiftUI

struct StampLargeView: View {
    
    var skyColor: LinearGradient
    var skyImage: Image
    var isSmiling: Bool
    var isBlinkingLeft: Bool
    var isBlinkingRight: Bool
    var lookAtPoint: SIMD3<Float>
    var faceOrientation: SIMD3<Float>
    var bodyColor: LinearGradient
    var eyeColor: LinearGradient
    var cheekColor: LinearGradient
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(skyColor)
                    .shadow(color: Color.gray.opacity(0.5), radius: 12, x: 0, y: 8)
                
                skyImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                EyeView(isSmiling: isSmiling, isBlinkingLeft: isBlinkingLeft, isBlinkingRight: isBlinkingRight, lookAtPoint: lookAtPoint, faceOrientation: faceOrientation, bodyColor: bodyColor, eyeColor: eyeColor, cheekColor: cheekColor)
                    .frame(width: geo.size.width * 0.7)
                RoundedRectangle(cornerRadius: 50)
                    .strokeBorder(Color.black, lineWidth: 2)
                
            }//Zstack
            .frame(width: geo.size.width, height: geo.size.width, alignment: .center)
            .offset(y: geo.size.height / 2 - geo.size.width / 2)
        }//GeometryReader
    }
}


struct StampLargeView_Previews: PreviewProvider {
    static var previews: some View {
        StampLargeView(skyColor: LinearGradient.sky.clearMorning, skyImage: Image.assets.stampLarge.clearMorning, isSmiling: false, isBlinkingLeft: false, isBlinkingRight: false, lookAtPoint: SIMD3<Float>(0.0, 0.0, 0.0), faceOrientation: SIMD3<Float>(0.0, 0.0, 0.0), bodyColor: LinearGradient.userCyan, eyeColor: LinearGradient.eyeCyan, cheekColor: LinearGradient.cheekRed)
    }
}
//
//struct StampLDesign: View {
//    
//    @StateObject var weather: WeatherViewModel = WeatherViewModel()
//    @StateObject var time: TimeViewModel = TimeViewModel()
//    var isAttendanceView: Bool
//    var isStamped: Bool
//    
//    var body: some View {
//        // (1) AttendanceView에 나타나는 Stamp일 경우
//        if isAttendanceView == true && isStamped == false {
//            StampLargeView(skyColor: Color.sky.unStampedWhite, skyImage: "", scale: 0.85)
//        }
//        // (2) AttendanceCompletedView에 나타나는 Stamp일 경우
//        if isAttendanceView == true && isStamped == true {
//            
//            switch weather.currentWeather {
//                // 맑은 날
//            case WeatherViewModel.clear:
//                StampLargeView(skyColor: time.isDayTime ? Color.sky.clearDay : Color.sky.clearNight, skyImage: "LargeStamp_clearDay", scale: 0.85)
//                
//                // 흐린 날
//            case WeatherViewModel.cloudy:
//                StampLargeView(skyColor: time.isDayTime ? Color.sky.cloudyDay : Color.sky.cloudyNight, skyImage: "LargeStamp_cloudyDay", scale: 0.85)
//                
//                // 비오는 날
//            case WeatherViewModel.rainy:
//                    StampLargeView(skyColor: time.isDayTime ? Color.sky.rainyDay : Color.sky.rainyNight, skyImage: "LargeStamp_rainyDay", scale: 0.85)
//                
//                // 눈 오는 날
//            case WeatherViewModel.snowy:
//                    StampLargeView(skyColor: time.isDayTime ? Color.sky.snowyDay : Color.sky.snowyNight, skyImage: "LargeStamp_snowyDay", scale: 0.85)
//                
//                // 번개 치는 날
//            case WeatherViewModel.thunder:
//                    StampLargeView(skyColor: time.isDayTime ? Color.sky.cloudyDay : Color.sky.cloudyNight, skyImage: "LargeStamp_thunder", scale: 0.85)
//            default:
//                EmptyView()
//            }
//        }
//        
//        // (3) CalendarDayView에 나타나는 Stamp일 경우
//        if isAttendanceView == false && isStamped == true {
//            
//        }
//    }
//}
//
//
//struct StampLDesign_Previews: PreviewProvider {
//    static var previews: some View {
//        StampLDesign(isAttendanceView: true, isStamped: true)
//    }
//}
