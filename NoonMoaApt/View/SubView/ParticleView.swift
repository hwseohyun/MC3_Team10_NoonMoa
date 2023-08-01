//
//  ParticleView.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/08/02.
//

import SwiftUI


@ViewBuilder
func CustomButton (systemImage: String, status: Bool, activeTint: Color, inActiveTint: Color, onTap: @escaping () -> ()) -> some View {
    Button(action: onTap) {
        
        Image (systemName: systemImage)
            .font(.title2)
            .particleEffect(systemImage: systemImage,
                            font: .title2,
                            status: status,
                            activeTint: activeTint,
                            inActiveTint: inActiveTint)
            .foregroundColor(status ? activeTint : inActiveTint)
            .padding(.horizontal, 10)
            .background{
                Capsule()
                    .fill(status ? activeTint.opacity(0.25) : Color("ButtonColor"))
            }
    }
}

