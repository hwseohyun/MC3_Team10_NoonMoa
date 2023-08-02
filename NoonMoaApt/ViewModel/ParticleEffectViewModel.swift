//
//  ParticleEffectViewModel.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/08/02.
//

import Foundation
import SwiftUI

struct Particle: Identifiable {
    var id: UUID = .init()
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var scale: CGFloat = 0
    var opacity: CGFloat = 1
    
    mutating func reset() {
        offsetX = 0
        offsetY = 0
        scale = 0
        opacity = 1
    }
}


extension View {
    @ViewBuilder
    func particleEffect(systemImage: String, font: Font, status: Bool, tint: Color) -> some View {
        self
            .modifier(ParticleModifier(systemImage: systemImage, font: font, status: status, tint: tint))
    }
}


fileprivate struct ParticleModifier: ViewModifier {
    var systemImage: String
    var font: Font
    var status: Bool
    var tint: Color

    @State private var particle: Particle = Particle(offsetX: 0, offsetY: 0, scale: 1, opacity: 1)
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .center){
                ZStack{
                    Image(systemName: systemImage)
                        .foregroundColor(tint)
                        .font(font)
                        .overlay (
                            Image(systemName: "suit.heart")
                                .foregroundColor(.black)
                                .opacity(0.3)
                                .font(font)
                                .fontWeight(.light)
                        )
                        .scaleEffect(particle.scale)
                        .offset(x: particle.offsetX, y: particle.offsetY)
                        .opacity(particle.opacity)
                        .opacity(status ? 1 : 0)
                }
                .onChange(of: status) { bool in
                    if !bool {
                        particle.reset()
                    } else {
                        DispatchQueue.main.async {
                            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.8)){
                                particle.offsetY = -56
                            }
                            withAnimation(.easeOut(duration: 0.4)) {
                                particle.scale = 1.5
                            }
                            withAnimation(.easeOut(duration: 0.2).delay(0.4)) {
                                particle.opacity = 0
                            }
                        }
                    }
                }
            }
    }
}
