//
//  SceneBroadcast.swift
//  NoonMoaApt
//
//  Created by 최민규 on 2023/07/31.
//

import SwiftUI

struct SceneBroadcast: View {
    @EnvironmentObject var environmentModel: EnvironmentModel
    
    //글자 타이핑 이펙트
    @State private var displayedText: String = ""
    @State private var fullText: String = ""
    let typingInterval = 0.15
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 56)
                Text(displayedText)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .shadow(color: .gray, radius: 6, x: 0, y: 4)
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 32)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                displayedText = ""
                fullText = environmentModel.currentBroadcastText
                startTyping()
            }
        }
        .onChange(of: displayedText) { _ in
            if displayedText.count == fullText.count {
                withAnimation(.easeInOut(duration: 2).delay(2)) {
                    displayedText = ""
                }
            }
        }
    }
    
    private func startTyping() {
        var currentIndex = 0
        let timer = Timer.scheduledTimer(withTimeInterval: typingInterval, repeats: true) { timer in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText += String(fullText[index])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
        timer.fire()
    }
}

struct SceneBroadcast_Previews: PreviewProvider {
    static var previews: some View {
        SceneBroadcast().environmentObject(EnvironmentModel())
    }
}
