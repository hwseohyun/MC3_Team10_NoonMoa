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
    
    struct stampBorder {
        static let clearSunrise = Color(hex: 0xABD5ED)
        static let clearMorning = Color(hex: 0xABD5ED)
        static let clearAfternoon = Color(hex: 0xABD5ED)
        static let clearSunset = Color(hex: 0x3A4C8B)
        static let clearEvening = Color(hex: 0x3A4C8B)
        static let clearNight = Color(hex: 0x3A4C8B)
        
        static let cloudySunrise = Color(hex: 0xB3B4B4)
        static let cloudyMorning = Color(hex: 0xB3B4B4)
        static let cloudyAfternoon = Color(hex: 0xB3B4B4)
        static let cloudySunset = Color(hex: 0x5A6384)
        static let cloudyEvening = Color(hex: 0x5A6384)
        static let cloudyNight = Color(hex: 0x5A6384)
        
        static let rainySunrise = Color(hex: 0xB3B4B4)
        static let rainyMorning = Color(hex: 0xB3B4B4)
        static let rainyAfternoon = Color(hex: 0xB3B4B4)
        static let rainySunset = Color(hex: 0x5A6384)
        static let rainyEvening = Color(hex: 0x5A6384)
        static let rainyNight = Color(hex: 0x5A6384)
        
        static let snowySunrise = Color(hex: 0xB8CBEE)
        static let snowyMorning = Color(hex: 0xB8CBEE)
        static let snowyAfternoon = Color(hex: 0xB8CBEE)
        static let snowySunset = Color(hex: 0x56509A)
        static let snowyEvening = Color(hex: 0x56509A)
        static let snowyNight = Color(hex: 0x56509A)
    }
}

extension LinearGradient {
    
    static let gradationGray = LinearGradient(colors: [Color(hex: 0xDDDDDD), Color(hex: 0xFFFFFF)], startPoint: .top, endPoint: .bottom)
    
    static let userPink = LinearGradient(colors: [Color(hex: 0xFFBFBF), Color(hex: 0xDC7E7E)], startPoint: .top, endPoint: .bottom)
    static let userYellow = LinearGradient(colors: [Color(hex: 0xF9FECA), Color(hex: 0xD4DA97)], startPoint: .top, endPoint: .bottom)
    static let userCyan = LinearGradient(colors: [Color(hex: 0xC5E3E3), Color(hex: 0x8BB2B2)], startPoint: .top, endPoint: .bottom)
    static let userBlue = LinearGradient(colors: [Color(hex: 0xB9BCE7), Color(hex: 0x8A8DC5)], startPoint: .top, endPoint: .bottom)
    static let unStampedWhite = LinearGradient(colors: [Color(hex: 0xFFFFFF).opacity(0.5), Color(hex: 0xFFFFFF)], startPoint: .top, endPoint: .bottom)
    
    static let eyePink = LinearGradient(colors: [Color(hex: 0xFFBFBF), Color(hex: 0xFFBFBF)], startPoint: .top, endPoint: .bottom)
    static let eyeYellow = LinearGradient(colors: [Color(hex: 0xF8FBD9), Color(hex: 0xF8FBD9)], startPoint: .top, endPoint: .bottom)
    static let eyeCyan = LinearGradient(colors: [Color(hex: 0xC5E3E3), Color(hex: 0xC5E3E3)], startPoint: .top, endPoint: .bottom)
    static let eyeBlue = LinearGradient(colors: [Color(hex: 0xB9BCE7), Color(hex: 0xB9BCE7)], startPoint: .top, endPoint: .bottom)
    
    static let cheekGray = LinearGradient(colors: [Color(hex: 0x888888), Color(hex: 0xAAAAAA)], startPoint: .top, endPoint: .bottom)
    static let cheekRed = LinearGradient(colors: [Color(hex: 0xFF6666), Color(hex: 0xFF0000)], startPoint: .top, endPoint: .bottom)
    
    
    struct sky {
        
        static let clearSunrise = LinearGradient(colors: [Color(hex: 0xBCD8E9), Color(hex: 0xFFD9D9)], startPoint: .top, endPoint: .bottom)
        static let clearMorning = LinearGradient(colors: [Color(hex: 0xA9D4EC), Color(hex: 0xDAEBF5)], startPoint: .top, endPoint: .bottom)
        static let clearAfternoon = LinearGradient(colors: [Color(hex: 0xA9D4EC), Color(hex: 0xDAEBF5)], startPoint: .top, endPoint: .bottom)
        static let clearSunset = LinearGradient(gradient: Gradient(colors: [Color(hex: 0xC4DCE1), Color(hex: 0xDAC1AF), Color(hex: 0xF2A482)]), startPoint: .top, endPoint: .bottom)
        static let clearEvening = LinearGradient(colors: [Color(hex: 0x26537D), Color(hex: 0xA8CAE9)], startPoint: .top, endPoint: .bottom)
        static let clearNight = LinearGradient(colors: [Color(hex: 0x232F5A), Color(hex: 0xADB8E0)], startPoint: .top, endPoint: .bottom)
        
        static let cloudySunrise = LinearGradient(colors: [Color(hex: 0xBCD8E9), Color(hex: 0xFFD9D9)], startPoint: .top, endPoint: .bottom)
        static let cloudyMorning = LinearGradient(colors: [Color(hex: 0xB1B1B1), Color(hex: 0xE4EDF5)], startPoint: .top, endPoint: .bottom)
        static let cloudyAfternoon = LinearGradient(colors: [Color(hex: 0xB1B1B1), Color(hex: 0xE4EDF5)], startPoint: .top, endPoint: .bottom)
        static let cloudySunset = LinearGradient(gradient: Gradient(colors: [Color(hex: 0xC4DCE1), Color(hex: 0xDAC1AF), Color(hex: 0xF2A482)]), startPoint: .top, endPoint: .bottom)
        static let cloudyEvening = LinearGradient(colors: [Color(hex: 0x565F81), Color(hex: 0xB3B9CD)], startPoint: .top, endPoint: .bottom)
        static let cloudyNight = LinearGradient(colors: [Color(hex: 0x565F81), Color(hex: 0xB3B9CD)], startPoint: .top, endPoint: .bottom)
        
        static let rainySunrise = LinearGradient(colors: [Color(hex: 0xBCD8E9), Color(hex: 0xFFD9D9)], startPoint: .top, endPoint: .bottom)
        static let rainyMorning = LinearGradient(colors: [Color(hex: 0xB1B1B1), Color(hex: 0xE4EDF5)], startPoint: .top, endPoint: .bottom)
        static let rainyAfternoon = LinearGradient(colors: [Color(hex: 0xB1B1B1), Color(hex: 0xE4EDF5)], startPoint: .top, endPoint: .bottom)
        static let rainySunset = LinearGradient(gradient: Gradient(colors: [Color(hex: 0xC4DCE1), Color(hex: 0xDAC1AF), Color(hex: 0xF2A482)]), startPoint: .top, endPoint: .bottom)
        static let rainyEvening = LinearGradient(colors: [Color(hex: 0x565F81), Color(hex: 0xB3B9CD)], startPoint: .top, endPoint: .bottom)
        static let rainyNight = LinearGradient(colors: [Color(hex: 0x565F81), Color(hex: 0xB3B9CD)], startPoint: .top, endPoint: .bottom)
        
        static let snowySunrise = LinearGradient(colors: [Color(hex: 0xBCD8E9), Color(hex: 0xFFD9D9)], startPoint: .top, endPoint: .bottom)
        static let snowyMorning = LinearGradient(colors: [Color(hex: 0xB8CBEF), Color(hex: 0xB4B7BD)], startPoint: .top, endPoint: .bottom)
        static let snowyAfternoon = LinearGradient(colors: [Color(hex: 0xB8CBEF), Color(hex: 0xB4B7BD)], startPoint: .top, endPoint: .bottom)
        static let snowySunset = LinearGradient(gradient: Gradient(colors: [Color(hex: 0xC4DCE1), Color(hex: 0xDAC1AF), Color(hex: 0xF2A482)]), startPoint: .top, endPoint: .bottom)
        static let snowyEvening = LinearGradient(colors: [Color(hex: 0x514B98), Color(hex: 0xBCBBC9)], startPoint: .top, endPoint: .bottom)
        static let snowyNight = LinearGradient(colors: [Color(hex: 0x514B98), Color(hex: 0xBCBBC9)], startPoint: .top, endPoint: .bottom)
        
        static let unStampedWhite = LinearGradient(colors: [Color(hex: 0xFFFFFF).opacity(0.5), Color(hex: 0xFFFFFF).opacity(0.5)], startPoint: .top, endPoint: .bottom)
    }
    
    struct ground {
        static let grassGreen = LinearGradient(colors: [Color(hex: 0x768D72), Color(hex: 0x9FC19A)], startPoint: .top, endPoint: .bottom)
        static let dirtBrown = LinearGradient(colors: [Color(hex: 0x7D7E6C), Color(hex: 0xB0B19A)], startPoint: .top, endPoint: .bottom)
        static let snowWhite = LinearGradient(colors: [Color(hex: 0xCECECE), Color(hex: 0xFFFFFF)], startPoint: .top, endPoint: .bottom)
        static let pathBeige = LinearGradient(colors: [Color(hex: 0xE1DCD3), Color(hex: 0xF0EAE0)], startPoint: .top, endPoint: .bottom)
        
        
        static let clearSunrise = LinearGradient.ground.grassGreen
        static let clearMorning = LinearGradient.ground.grassGreen
        static let clearAfternoon = LinearGradient.ground.grassGreen
        static let clearSunset = LinearGradient.ground.grassGreen
        static let clearEvening = LinearGradient.ground.grassGreen
        static let clearNight = LinearGradient.ground.grassGreen
        
        static let cloudySunrise = LinearGradient.ground.dirtBrown
        static let cloudyMorning = LinearGradient.ground.dirtBrown
        static let cloudyAfternoon = LinearGradient.ground.dirtBrown
        static let cloudySunset = LinearGradient.ground.dirtBrown
        static let cloudyEvening = LinearGradient.ground.dirtBrown
        static let cloudyNight = LinearGradient.ground.dirtBrown
        
        static let rainySunrise = LinearGradient.ground.dirtBrown
        static let rainyMorning = LinearGradient.ground.dirtBrown
        static let rainyAfternoon = LinearGradient.ground.dirtBrown
        static let rainySunset = LinearGradient.ground.dirtBrown
        static let rainyEvening = LinearGradient.ground.dirtBrown
        static let rainyNight = LinearGradient.ground.dirtBrown
        
        static let snowySunrise = LinearGradient.ground.snowWhite
        static let snowyMorning = LinearGradient.ground.snowWhite
        static let snowyAfternoon = LinearGradient.ground.snowWhite
        static let snowySunset = LinearGradient.ground.snowWhite
        static let snowyEvening = LinearGradient.ground.snowWhite
        static let snowyNight = LinearGradient.ground.snowWhite
    }
}

extension Image {
    
    struct symbol {
        static let moon = Image(systemName: "moon.fill")
    }
    
    struct assets {
        static let apartment = Image("Apartment")
        
        struct room {
            static let vacant = Image("Room_vacant")
            static let dark = Image("Room_dark")
            static let light = Image("Room_light")
            static let blind = Image("Room_blind")
            static let blindUp = Image("Room_blindUp")
        }
        
        struct stampLarge {
            static let clearSunrise = Image("StampLarge_clearDay")
            static let clearMorning = Image("StampLarge_clearDay")
            static let clearAfternoon = Image("StampLarge_clearDay")
            static let clearSunset = Image("StampLarge_clearNight")
            static let clearEvening = Image("StampLarge_clearNight")
            static let clearNight = Image("StampLarge_clearNight")
            
            static let cloudySunrise = Image("StampLarge_cloudyDay")
            static let cloudyMorning = Image("StampLarge_cloudyDay")
            static let cloudyAfternoon = Image("StampLarge_cloudyDay")
            static let cloudySunset = Image("StampLarge_cloudyNight")
            static let cloudyEvening = Image("StampLarge_cloudyNight")
            static let cloudyNight = Image("StampLarge_cloudyNight")
            
            static let rainySunrise = Image("StampLarge_rainyDay")
            static let rainyMorning = Image("StampLarge_rainyDay")
            static let rainyAfternoon = Image("StampLarge_rainyDay")
            static let rainySunset = Image("StampLarge_rainyNight")
            static let rainyEvening = Image("StampLarge_rainyNight")
            static let rainyNight = Image("StampLarge_rainyNight")
            
            static let snowySunrise = Image("StampLarge_snowyDay")
            static let snowyMorning = Image("StampLarge_snowyDay")
            static let snowyAfternoon = Image("StampLarge_snowyDay")
            static let snowySunset = Image("StampLarge_snowyDay")
            static let snowyEvening = Image("StampLarge_snowyDay")
            static let snowyNight = Image("StampLarge_snowyDay")
            
            static let wind = Image("StampLarge_wind")
            static let thunder = Image("StampLarge_thunder")
        }
        
        struct stampSmall {
            static let clearSunrise = Image("StampSmall_clearDay")
            static let clearMorning = Image("StampSmall_clearDay")
            static let clearAfternoon = Image("StampSmall_clearDay")
            static let clearSunset = Image("StampSmall_clearNight")
            static let clearEvening = Image("StampSmall_clearNight")
            static let clearNight = Image("StampSmall_clearNight")
            
            static let cloudySunrise = Image("StampSmall_cloudyDay")
            static let cloudyMorning = Image("StampSmall_cloudyDay")
            static let cloudyAfternoon = Image("StampSmall_cloudyDay")
            static let cloudySunset = Image("StampSmall_cloudyNight")
            static let cloudyEvening = Image("StampSmall_cloudyNight")
            static let cloudyNight = Image("StampSmall_cloudyNight")
            
            static let rainySunrise = Image("StampSmall_rainyDay")
            static let rainyMorning = Image("StampSmall_rainyDay")
            static let rainyAfternoon = Image("StampSmall_rainyDay")
            static let rainySunset = Image("StampSmall_rainyNight")
            static let rainyEvening = Image("StampSmall_rainyNight")
            static let rainyNight = Image("StampSmall_rainyNight")
            
            static let snowySunrise = Image("StampSmall_snowyDay")
            static let snowyMorning = Image("StampSmall_snowyDay")
            static let snowyAfternoon = Image("StampSmall_snowyDay")
            static let snowySunset = Image("StampSmall_snowyDay")
            static let snowyEvening = Image("StampSmall_snowyDay")
            static let snowyNight = Image("StampSmall_snowyDay")
            
            static let wind = Image("StampSmall_wind")
            static let thunder = Image("StampSmall_thunder")
        }
    }
}
    
struct Lottie {
    static let clearSunrise = String("clearD")
    static let clearMorning = String("clearD")
    static let clearAfternoon = String("clearD")
    static let clearSunset = String("clearN")
    static let clearEvening = String("clearN")
    static let clearNight = String("clearN")
    
    static let cloudySunrise = String("cloudyD")
    static let cloudyMorning = String("cloudyD")
    static let cloudyAfternoon = String("cloudyD")
    static let cloudySunset = String("cloudyN")
    static let cloudyEvening = String("cloudyN")
    static let cloudyNight = String("cloudyN")
    
    static let rainySunrise = String("rainyD")
    static let rainyMorning = String("rainyD")
    static let rainyAfternoon = String("rainyD")
    static let rainySunset = String("rainyN")
    static let rainyEvening = String("rainyN")
    static let rainyNight = String("rainyN")
    
    static let snowySunrise = String("snowyD")
    static let snowyMorning = String("snowyD")
    static let snowyAfternoon = String("snowyD")
    static let snowySunset = String("snowyN")
    static let snowyEvening = String("snowyN")
    static let snowyNight = String("snowyN")
    
    static let wind = String("WindDN")
    static let thunder = String("thunderDN")
}

extension Text {
    struct broadcast{
        static let clearSunrise = String("clearSunrise")
        static let clearMorning = String("clearMorning")
        static let clearAfternoon = String("clearAfternoon")
        static let clearSunset = String("clearSunset")
        static let clearEvening = String("clearEvening")
        static let clearNight = String("clearNight")
        
        static let cloudySunrise = String("cloudySunrise")
        static let cloudyMorning = String("cloudyMorning")
        static let cloudyAfternoon = String("cloudyAfternoon")
        static let cloudySunset = String("cloudySunset")
        static let cloudyEvening = String("cloudyEvening")
        static let cloudyNight = String("cloudyNight")
        
        static let rainySunrise = String("rainySunrise")
        static let rainyMorning = String("rainyMorning")
        static let rainyAfternoon = String("rainyAfternoon")
        static let rainySunset = String("rainySunset")
        static let rainyEvening = String("rainyEvening")
        static let rainyNight = String("rainyNight")
        
        static let snowySunrise = String("snowySunrise")
        static let snowyMorning = String("snowyMorning")
        static let snowyAfternoon = String("snowyAfternoon")
        static let snowySunset = String("snowySunset")
        static let snowyEvening = String("snowyEvening")
        static let snowyNight = String("snowyNight")
        
        static let wind = String("wind")
        static let thunder = String("thunder")
    }
}
