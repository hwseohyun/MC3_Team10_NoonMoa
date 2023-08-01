//
//  EyeNeighborView.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/25.
//

import SwiftUI

struct SceneNeighborEye: View {
    @Binding var roomUser: User
    @State private var eyeNeighborModel = EyeNeighborViewModel()
    
    var body: some View {
        EyeView(isSmiling: eyeNeighborModel.isSmiling,
                isBlinkingLeft: eyeNeighborModel.isBlinkingLeft,
                isBlinkingRight: eyeNeighborModel.isBlinkingRight,
                lookAtPoint: eyeNeighborModel.lookAtPoint,
                faceOrientation: eyeNeighborModel.faceOrientation,
                bodyColor: eyeNeighborModel.bodyColor,
                eyeColor: eyeNeighborModel.eyeColor, cheekColor: eyeNeighborModel.cheekColor)
        .onAppear {
            eyeNeighborModel.update(roomUser: roomUser)
            //이웃 눈의 랜덤한 움직임 함수 실행
            withAnimation(.linear(duration: 3)) {
                eyeNeighborModel.randomEyeMove(roomUser: roomUser)
            }
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: 3)) {
                        eyeNeighborModel.randomEyeMove(roomUser: roomUser)
                    }
                }
            }
        }
    }
}

struct SceneNeighborEye_Previews: PreviewProvider {
    static var previews: some View {
        SceneNeighborEye(roomUser: .constant(User.sampleData[0][1]))
    }
}
