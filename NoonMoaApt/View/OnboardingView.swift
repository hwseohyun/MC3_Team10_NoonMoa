//
//  OnboardingView.swift
//  MC3
//
//  Created by Niko Yejin Kim on 2023/07/19.
//

import SwiftUI
import Foundation

//온보딩탭뷰에 담길 데이터
struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let onboardingImage: String
    let titleText: String
    let contentText: String
    
    static let datalist: [OnboardingData] = [
        OnboardingData(id: 0, onboardingImage: "onboarding1", titleText: "매일 눈도장으로 하루 시작하기", contentText: "아침에 눈을 반짝 떠서 출석 도장을 찍어주세요. 눈도장을 찍는 순간 집 바깥의 날씨가 보여지며\n멋진 하루의 시작을 장식해줄 거예요."),
        OnboardingData(id: 1, onboardingImage: "onboarding2", titleText: "눈모아 아파트에서 공동생활하기", contentText: "익명의 이웃 주민들과 눈을 통해 서로의 존재를 확인하세요. 오랫동안 눈도장을 찍지 않은 이웃은 직접 깨워 안부를 전할 수 있어요."),
        OnboardingData(id: 2, onboardingImage: "onboarding3", titleText: "날마다 기록된 눈도장 모아보기", contentText: "매일 아침 찍은 눈도장들이 모이는 과정을 즐겨보세요. 꾸준히 작은 실천을 통해 일상의 루틴을 형성하는 좋은 동기부여가 될 거예요.")
    ]
}

//온보딩 데이터를 보여주는 온보딩탭뷰 그리기
struct OnboardingTabView: View {
    var data: OnboardingData
    
    var body: some View {
        VStack {
            //가장 상단에는 이미지
            Image(data.onboardingImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 300)
                
            //띄우기
            Spacer()
                .frame(height: 90)
            
            //타이틀 텍스트
            Text(data.titleText)
                .font(.system(size: 26, weight: .bold))
                .multilineTextAlignment(.center)
            
            //띄우기
            Spacer()
                .frame(height: 20)
            
            //콘텐츠 텍스트
            Text(data.contentText)
                .font(.system(size: 16))
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35.0)
                .foregroundColor(.gray)
        }
    }
}

//온보딩뷰 화면 그리기
struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var tag:Int? = nil
    @State private var currentTab = 0
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    
    var body: some View {
        
        NavigationView{
            ZStack{
            
                //배경색
                LinearGradient.sky.clearMorning.opacity(0.3)
                
                VStack{
                        //화면 가장 위에서부터 띄우기
                        Spacer()
                        .frame(height: 30)
                    
                    //SKIP 버튼을 위한 HStack
                    HStack{
                        
                        //가장 오른쪽으로 밀기 위한 띄우기
                        Spacer()
                        
                        //SKIP 버튼 조건 : 온보딩탭뷰가 마지막 탭이 아닐 때
                        if currentTab < OnboardingData.datalist.count - 1 {
                            Button(action: {
                                //마지막 탭으로 이동
                                self.currentTab = OnboardingData.datalist.count - 1
                            }, label: {
                                Text("SKIP")
                                    .padding(.trailing, 30)
                                    .foregroundColor(.gray)
                                    .font(.system(size:15))
                            })
                        }
                        //SKIP 버튼 조건 : 온보딩탭뷰가 마지막 탭일 때
                        else {
                            Button(action: {
                                self.currentTab = OnboardingData.datalist.count - 1
                            }, label: {
                                Text("SKIP")
                                    .padding(.trailing, 30)
                                    .foregroundColor(.clear) //안 보이게
                                    .font(.system(size:15))
                            })
                        }
                    }
                    
                    //온보딩데이터의 데이터 하나씩 넣어서 보여주는 탭뷰
                    TabView(selection: $currentTab,
                            content:  {
                        ForEach(OnboardingData.datalist) { viewData in
                            OnboardingTabView(data: viewData)
                                .tag(viewData.id)
                        }
                    })
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) //기본 인덱스 도트 없애기
                   
                    
                    //커스텀 인덱스 도트
                                    HStack {
                                            //현재 탭 위치 보여주는 방식
                                        ForEach(OnboardingData.datalist) { viewData in
                                            
                                            if viewData.id == currentTab {
                                                Rectangle()
                                                    .frame(width: 10, height: 10)
                                                    .cornerRadius(10)
                                                    .foregroundColor(.gray)
                                            }
                                            //나머지 탭 보여주는 방식
                                            else {
                                                Circle()
                                                    .frame(width: 10, height: 10)
                                                    .opacity(0.3) //흐린 회색
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    .padding(.top, -30)
                    
                    Spacer()
                        .frame(height: 75)
                    
                    //다음 & 시작하기 버튼
                    //마지막 탭이 아닐 때
                    if currentTab < OnboardingData.datalist.count - 1 {
                        Button(action: {
                            self.currentTab += 1
                        }, label: {
                            Text("다음")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundColor(Color.gray)
                                        .frame(width: 345, height: 56)
                                )
                        })
                    }
                    //마지막 탭일 때
                    else {
                        Button {
                            isOnboardingDone = true
                            viewRouter.nextView = .login
                        } label: {
                            Text("시작하기")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 13)
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                        .frame(width: 345, height: 56)
                                )
                        }
                    }
                    
                    //띄우기
                    Spacer()
                        .frame(height: 50)
                }
                .navigationTitle("")
            }.ignoresSafeArea()
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
