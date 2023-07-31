//
//  SceneButtons.swift
//  MC3
//
//  Created by 최민규 on 2023/07/16.
//

import SwiftUI

struct SceneButtons: View {

    @EnvironmentObject var eyeViewController: EyeViewController

    @Binding var roomUser: User
    @Binding var buttonText: String
    
    @State private var lastActiveToggle: Bool = false
    @State private var lastWakenTimeToggle: Bool = false
    
    let pushNotiController = PushNotiController()
    
    var body: some View {
        
        ZStack {
            Color.clear
            
            switch roomUser.userState {
            case "sleep":
                Button(action: {
                    buttonText = "\(roomUser.roomId ?? "")\nsleep"
                    lastActiveToggle = true
                }) {
                    Color.clear
                        .cornerRadius(8)
                }
                //깨우기버튼
                ZStack {
                    Color.black
                        .cornerRadius(8)
                        .opacity(0.3)
                    
                    VStack {
                        HStack {
                            Image.symbol.moon
                                .foregroundColor(.white)
                                .font(.body)
                            Text("3일")
                                .foregroundColor(.white)
                                .font(.body)
                                .bold()
                        }//HStack
                        .offset(y: 4)
                        //오프셋 보정
                        Button(action: {
                            lastActiveToggle = false
                            lastWakenTimeToggle = true
                            buttonText = "\(roomUser.roomId ?? "")\n깨우는 중"
                        }) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black)
                                .opacity(0.3)
                                .frame(width: 80, height: 36)
                                .overlay(
                                    Text("깨우기")
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .bold()
                                )
                        }
                        .offset(y: -4)
                        //오프셋 보정
                    }
                }//ZStack
                .opacity(lastActiveToggle ? 1 : 0)
                
                //깨우는 중...
                ZStack {
                    Color.black
                        .cornerRadius(8)
                        .opacity(0.3)
                    
                    VStack {
                            Text("깨우는 중...")
                                .foregroundColor(.white)
                                .font(.caption)
                                .bold()
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.black)
                                .opacity(0.5)
                                .frame(width: 64, height: 8)

                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 8)
                                    .offset(x: -16)
                        }
                    }//VStack
                    
                    Button(action: {
                        lastWakenTimeToggle = false
                        buttonText = "\(roomUser.roomId ?? "")\n시간 종료"
                    }) {
                        Color.clear
                            .cornerRadius(8)
                    }
                }//ZStack
                .opacity(lastWakenTimeToggle ? 1 : 0)
                
            case "active":
                Button(action: {
                    buttonText = "\(roomUser.roomId ?? "")\nactive"
                    DispatchQueue.main.async {
                        pushNotiController.requestPushNotification(to: roomUser.id!)
                    }
                    if roomUser.roomId == "5" {
                        eyeViewController.resetFaceAnchor()
                    }
                }) {
                    Color.clear
                        .cornerRadius(8)
                }
            case "inactive":
                Button(action: {
                    buttonText = "\(roomUser.roomId ?? "")\ninactive"
                }) {
                    Color.clear
                        .cornerRadius(8)
                }
            default :
                Button(action: {
                    buttonText = "\(roomUser.roomId ?? "")\nvacant"
                }) {
                    Color.clear
                        .cornerRadius(8)
                }
            }
        }//ZStack
    }
}

//struct SceneButtons_Previews: PreviewProvider {
//    @State static var user: User = User.sampleData[1][1]
//    @State static var buttonText: String = ""
//    static var previews: some View {
//        SceneButtons(roomUser: $user, buttonText: $buttonText)
//    }
//}
