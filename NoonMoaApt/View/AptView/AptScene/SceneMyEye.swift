//
//  EyeMyView.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/25.
//

import SwiftUI

struct SceneMyEye: View {
    @EnvironmentObject var eyeViewController: EyeViewController

    var body: some View {
        
        EyeView(isSmiling: eyeViewController.eyeMyViewModel.isSmiling,
                isBlinkingLeft: eyeViewController.eyeMyViewModel.isBlinkingLeft,
                isBlinkingRight: eyeViewController.eyeMyViewModel.isBlinkingRight,
                lookAtPoint: eyeViewController.eyeMyViewModel.lookAtPoint,
                faceOrientation: eyeViewController.eyeMyViewModel.faceOrientation,
                bodyColor: eyeViewController.eyeMyViewModel.bodyColor,
                eyeColor: eyeViewController.eyeMyViewModel.eyeColor, cheekColor: eyeViewController.eyeMyViewModel.cheekColor)
    }
}



struct SceneMyEye_Previews: PreviewProvider {
    static var previews: some View {
        SceneMyEye()
    }
}
