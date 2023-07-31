//
//  SceneWeather.swift
//  MC3
//
//  Created by 최민규 on 2023/07/15.
//

import SwiftUI
import Lottie

struct SceneWeather: View {
    @EnvironmentObject var environmentModel: EnvironmentModel
    
    var body: some View {
        LottieView(name: environmentModel.currentLottieImageName, animationSpeed: 1)
                .ignoresSafeArea()
               
    }
}

struct SceneWeather_Previews: PreviewProvider {
    static var previews: some View {
        SceneWeather()
            .environmentObject(EnvironmentModel())
    }
}
