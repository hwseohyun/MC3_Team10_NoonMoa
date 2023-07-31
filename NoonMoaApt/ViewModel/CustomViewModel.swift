//
//  CustomViewModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import Foundation
import SwiftUI

class CustomViewModel: ObservableObject {
    @Published var currentCharacterColor: [Float] = [0.0, 0.0, 0.0]
    
    @Published var currentBodyColor: LinearGradient = LinearGradient.userPink
    @Published var currentEyeColor: LinearGradient = LinearGradient.eyePink
    @Published var currentCheekColor: LinearGradient = LinearGradient.cheekRed
 
    func convertCharacterColorToGradient(characterColor: [Float]) {
        let bodyColor = Color(red: Double(characterColor[0]), green: Double(characterColor[1]), blue: Double(characterColor[2]), opacity: 1.0)
        let eyeColor = Color(red: Double(characterColor[0]), green: Double(characterColor[1]), blue: Double(characterColor[2]), opacity: 1.0)
        let cheekColor = Color(red: Double(characterColor[0]), green: Double(characterColor[1]), blue: Double(characterColor[2]), opacity: 1.0)
        
        //받은 컬러 Float을 막 연산해서 각각에 뿌려주는 형태
        currentBodyColor = LinearGradient(gradient: Gradient(colors: [bodyColor, .white]), startPoint: .top, endPoint: .bottom)
        currentEyeColor = LinearGradient(gradient: Gradient(colors: [eyeColor, .white]), startPoint: .top, endPoint: .bottom)
        currentCheekColor = LinearGradient(gradient: Gradient(colors: [cheekColor, .white]), startPoint: .top, endPoint: .bottom)
    }
    //TODO: 저장된 값을 불러올 때 변환하는거는 안넣은듯?
}

