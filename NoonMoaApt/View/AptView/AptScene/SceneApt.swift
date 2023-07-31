//
//  SceneApt.swift
//  MC3
//
//  Created by 최민규 on 2023/07/15.
//

import SwiftUI

struct SceneApt: View {
    var body: some View {
        
        Image.assets.apartment
            .resizable()
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
    }
}

struct SceneApt_Previews: PreviewProvider {
    static var previews: some View {
        SceneApt()
    }
}
