//
//  LoginView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

// LoginView
import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject var loginData = LoginViewModel(viewRouter: ViewRouter())
    @AppStorage("isLogInDone") var isLogInDone: Bool = false
//    @Binding var roomUser: User
    @State private var eyeNeighborModel = EyeNeighborViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            EyeView(isSmiling: false,
                    isBlinkingLeft: false,
                    isBlinkingRight: true,
                    lookAtPoint: SIMD3<Float>(1.0, 0.0, 0.0),
                    faceOrientation: SIMD3<Float>(1.0, 0.0, 0.0),
                    bodyColor: LinearGradient.userBlue,
                    eyeColor: LinearGradient.eyeBlue,
                    cheekColor: LinearGradient.cheekRed)
//            .onAppear {
//                eyeNeighborModel.update(roomUser: roomUser)
//                //이웃 눈의 랜덤한 움직임 함수 실행
//                withAnimation(.linear(duration: 3)) {
//                    eyeNeighborModel.randomEyeMove(roomUser: roomUser)
//                }
                                .frame(width: 300, height: 300)
                                .padding(.bottom, 24)
            
                Text("눈모아 아파트에\n오신 걸 환영해요!")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                SignInWithAppleButton { (request) in
                    // 로그인 전에 Counter 문서가 없는 경우 초기화
                    loginData.initializeCountersIfNotExist()
                    
                    loginData.nonce = loginData.randomNonceString()
                    request.requestedScopes = [.email, .fullName]
                    request.nonce = loginData.sha256(loginData.nonce)
                    
                } onCompletion: { (result) in
                    switch result {
                    case .success(let user):
                        print("success")
                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                            print("error with firebase")
                            return
                        }
                        
                        loginData.authenticate(credential: credential)
                        // 임시방편, 미봉책
                        isLogInDone = true
                        viewRouter.nextView = .attendance
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .frame(width: 280, height: 45)
                .cornerRadius(10)
                .padding(.bottom)
                
                Text("By signing up, you agree to our Terms of Service and acknowledge that our Privacy Policy applies to you.")
                    .font(.caption)
                    .padding(.bottom, UIScreen.main.bounds.width * 0.17)
                    .padding(.horizontal, 32)
            }
            .ignoresSafeArea()
        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
