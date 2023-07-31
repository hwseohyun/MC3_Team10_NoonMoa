//
//  Color+Extension.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
            let red = Double((hex >> 16) & 0xff) / 255.0
            let green = Double((hex >> 8) & 0xff) / 255.0
            let blue = Double(hex & 0xff) / 255.0
            self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    static let systemGray = Color(hex: 0x787678)
    static let warmBlack = Color(hex: 0x333333)
    static let gradationGray = LinearGradient(colors: [Color(hex: 0xDDDDDD), Color(hex: 0xFFFFFF)], startPoint: .top, endPoint: .bottom)
    
    struct stampBorder {
        static let clearDay = Color(hex: 0xABD5ED)
        static let clearNight = Color(hex: 0x3A4C8B)
        static let cloudyDay = Color(hex: 0xB3B4B4)
        static let cloudyNight = Color(hex: 0x5A6384)
        static let snowyDay = Color(hex: 0xB8CBEE)
        static let snowyNight = Color(hex: 0x56509A)
    }
    
    struct sky {
        static let clearDay = LinearGradient(colors: [Color(hex: 0xA9D4EC), Color(hex: 0xDAEBF5)], startPoint: .top, endPoint: .bottom)
        static let clearNight = LinearGradient(colors: [Color(hex: 0x354787), Color(hex: 0xC2CFFB)], startPoint: .top, endPoint: .bottom)
        static let cloudyDay = LinearGradient(colors: [Color(hex: 0xB1B1B1), Color(hex: 0xE4EDF5)], startPoint: .top, endPoint: .bottom)
        static let cloudyNight = LinearGradient(colors: [Color(hex: 0x565F81), Color(hex: 0xB3B9CD)], startPoint: .top, endPoint: .bottom)
        static let rainyDay = LinearGradient(colors: [Color(hex: 0xB1B1B1), Color(hex: 0xE4EDF5)], startPoint: .top, endPoint: .bottom)
        static let rainyNight = LinearGradient(colors: [Color(hex: 0x565F81), Color(hex: 0xB3B9CD)], startPoint: .top, endPoint: .bottom)
        static let snowyDay = LinearGradient(colors: [Color(hex: 0xB8CBEF), Color(hex: 0xB4B7BD)], startPoint: .top, endPoint: .bottom)
        static let snowyNight = LinearGradient(colors: [Color(hex: 0x514B98), Color(hex: 0xBCBBC9)], startPoint: .top, endPoint: .bottom)
        static let unStampedWhite = LinearGradient(colors: [Color(hex: 0xFFFFFF).opacity(0.5), Color(hex: 0xFFFFFF).opacity(0.5)], startPoint: .top, endPoint: .bottom)
        static let sunrise = LinearGradient(colors: [Color(hex: 0xBCD8E9), Color(hex: 0xFFD9D9)], startPoint: .top, endPoint: .bottom)
        static let sunset = LinearGradient(stops: [
            Gradient.Stop(color: Color(hex: 0xC4DCE1),location: 0.00),
            Gradient.Stop(color: Color(hex: 0xDAC1AF), location: 0.50),
            Gradient.Stop(color: Color(hex: 0xF2A482), location: 1.00),
        ], startPoint: .top, endPoint: .bottom)
    }
    
    struct ground {
        static let grassGreen = LinearGradient(colors: [Color(hex: 0x768D72), Color(hex: 0x9FC19A)], startPoint: .top, endPoint: .bottom)
        static let dirtBrown = LinearGradient(colors: [Color(hex: 0x7D7E6C), Color(hex: 0xB0B19A)], startPoint: .top, endPoint: .bottom)
        static let snowWhite = LinearGradient(colors: [Color(hex: 0xCECECE), Color(hex: 0xFFFFFF)], startPoint: .top, endPoint: .bottom)
        static let pathBeige = LinearGradient(colors: [Color(hex: 0xE1DCD3), Color(hex: 0xF0EAE0)], startPoint: .top, endPoint: .bottom)
    }

}

extension LinearGradient {
    
    static let userPink = LinearGradient(colors: [Color(hex: 0xFFC8C8), Color(hex: 0xFD8A8A)], startPoint: .top, endPoint: .bottom)
    static let userYellow = LinearGradient(colors: [Color(hex: 0xFBFEDA), Color(hex: 0xF1F7B5)], startPoint: .top, endPoint: .bottom)
    static let userCyan = LinearGradient(colors: [Color(hex: 0xD0F0F0), Color(hex: 0xA8D1D1)], startPoint: .top, endPoint: .bottom)
    static let userBlue = LinearGradient(colors: [Color(hex: 0xCBCDEC), Color(hex: 0x9Ea1D4)], startPoint: .top, endPoint: .bottom)
    static let unStampedWhite = LinearGradient(colors: [Color(hex: 0xFFFFFF).opacity(0.5), Color(hex: 0xFFFFFF)], startPoint: .top, endPoint: .bottom)
    
    static let eyePink = LinearGradient(colors: [Color(hex: 0xFFC8C8), Color(hex: 0xFD8A8A)], startPoint: .top, endPoint: .bottom)
    static let eyeYellow = LinearGradient(colors: [Color(hex: 0xFBFEDA), Color(hex: 0xF1F7B5)], startPoint: .top, endPoint: .bottom)
    static let eyeCyan = LinearGradient(colors: [Color(hex: 0xD0F0F0), Color(hex: 0xA8D1D1)], startPoint: .top, endPoint: .bottom)
    static let eyeBlue = LinearGradient(colors: [Color(hex: 0xCBCDEC), Color(hex: 0x9Ea1D4)], startPoint: .top, endPoint: .bottom)
    
    static let cheekGray = LinearGradient(colors: [Color(hex: 0x888888), Color(hex: 0xAAAAAA)], startPoint: .top, endPoint: .bottom)
    static let cheekRed = LinearGradient(colors: [Color(hex: 0xFF6666), Color(hex: 0xFF0000)], startPoint: .top, endPoint: .bottom)
    
}

extension Image {
    
    struct symbol {
        static let moon = Image(systemName: "moon.fill")
    }
    
    struct assets {
        static let apartment = Image("Apartment")
        
        struct ground {
            static let grassGreen = Image("Ground_grassGreen")
            static let dirtBrown = Image("Ground_dirtBrown")
            static let snowWhite = Image("Ground_snowWhite")
        }
        
        struct room {
            static let vacant = Image("Room_vacant")
            static let dark = Image("Room_dark")
            static let light = Image("Room_light")
            static let blind = Image("Room_blind")
            static let blindUp = Image("Room_blindUp")
        }
        
        struct eye {
            static let active = Image("Eye_active")
            static let inactive = Image("Eye_inactive")
        }
        
        struct weather {
            static let clearDay = Image("Weather_clearDay")
            static let clearNight = Image("Weather_clearNight")
            static let cloudyDay = Image("Weather_cloudyDay")
            static let cloudyNight = Image("Weather_cloudyNight")
            static let rainyDay = Image("Weather_rainyDay")
            static let rainyNight = Image("Weather_rainyNight")
            static let snowyDay = Image("Weather_snowyDay")
            static let snowyNight = Image("Weather_snowyNight")
            static let thunder = Image("Weather_thunder")
        }
        
        struct largeStamp {
            static let clearDay = Image("LargeStamp_clearDay")
            static let clearNight = Image("LargeStamp_clearDay")
            static let cloudyDay = Image("LargeStamp_cloudyDay")
            static let cloudyNight = Image("LargeStamp_cloudyNight")
            static let rainyDay = Image("LargeStamp_rainyDay")
            static let rainyNight = Image("LargeStamp_rainyNight")
            static let snowyDay = Image("LargeStamp_snowyDay")
            static let snowyNight = Image("LargeStamp_snowyDay")//snowy는 Day, Night 디자인 동일
            static let thunder = Image("LargeStamp_thunder")
        }
        
        struct circleStamp {
            static let clearDay = Image("CircleStamp_clearDay")
            static let clearNight = Image("CircleStamp_clearDay")
            static let cloudyDay = Image("CircleStamp_cloudyDay")
            static let cloudyNight = Image("CircleStamp_cloudyNight")
            static let rainyDay = Image("CircleStamp_rainyDay")
            static let rainyNight = Image("CircleStamp_rainyNight")
            static let snowyDay = Image("CircleStamp_snowyDay")
            static let snowyNight = Image("CircleStamp_snowyDay")//snowy는 Day, Night 디자인 동일
            static let thunder = Image("CircleStamp_thunder")
        }
        
        
    }
}
    
struct Lottie {
    static let clearDay = String("clearD")
    static let clearNight = String("clearN")
    static let cloudyDay = String("cloudyD")
    static let cloudyNight = String("cloudyN")
    static let rainyDay = String("rainyD")
    static let rainyNight = String("rainyN")
    static let snowyDay = String("snowyDN")
    static let snowyNight = String("snowyDN")
    static let thunder = String("thunderDN")
}
