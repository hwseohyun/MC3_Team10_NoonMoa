//
//  MainView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/15.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @StateObject var attendanceModel: AttendanceModel
    @StateObject var characterModel: CharacterModel
    @StateObject var environmentModel: EnvironmentModel
    @StateObject var customViewModel: CustomViewModel
    @StateObject var calendarFullViewModel: CalendarFullViewModel
    @StateObject var calendarSingleController: CalendarSingleController
    @StateObject var loginViewModel: LoginViewModel
    @StateObject var aptModel: AptModel
    @StateObject var eyeViewController: EyeViewController
    
    var body: some View {
        
        switch viewRouter.currentView {
        case .launchScreen:
            launchScreenView()
        case .onBoarding:
            OnboardingView()
                .environmentObject(viewRouter)
        case .login:
            LoginView()
                .environmentObject(LoginViewModel(viewRouter: ViewRouter()))
        case .attendance:
//            let record = attendanceModel.ensureCurrentRecord()
            AttendanceView()
                .environmentObject(viewRouter)
                .environmentObject(attendanceModel)
                .environmentObject(environmentModel)
                .environmentObject(characterModel)
                .environmentObject(customViewModel)
                .environmentObject(eyeViewController)
        case .apt:
            AptView()
                .environmentObject(viewRouter)
                .environmentObject(attendanceModel)
                .environmentObject(environmentModel)
                .environmentObject(characterModel)
                .environmentObject(customViewModel)
                .environmentObject(eyeViewController)
            
        case .CalendarFull:
            CalendarFullView()
                .environmentObject(CalendarFullViewModel())
        case .CalendarSingle:
            CalendarSingleView()
                .environmentObject(calendarSingleController)
        default:
            LoginView()
                .environmentObject(LoginViewModel(viewRouter: ViewRouter()))
        }
    }
}
