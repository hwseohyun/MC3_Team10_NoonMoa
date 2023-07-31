//
//  TimeViewModel.swift
//  MC3
//
//  Created by 최민규 on 2023/07/17.
//

import SwiftUI

class TimeViewModel: ObservableObject {
    
    //TODO: 현재 시간에 따라서 새벽, 아침, 오후, 저녁 케이스에 따라 이미지가 Day, Night가 될 수 있게 뿌려주고, 텍스트가 변경될 수 있게 뿌려준다.

    //테스트용으로 비활성화
//    @Published var currentTime = Calendar.current.component(.hour, from: Date())
//
//    var isDayTime: Bool {
//        return currentTime >= 6 && currentTime < 18
//    }
    
    // var currentTime =  “Sunrise” “Morning” “Afternoon” “Sunset” “Evening” “Night”
    //테스트용, 버튼으로 시간 바꾸기 위해 사용
    @Published var currentTimeRaw: Date = Date() // Current time's raw data
    @Published var currentTime: String = ""      // Current time as a string
    
    func updateCurrentTime() {
        let dateFormatter = DateFormatter()
        let currentTimeString = dateFormatter.string(from: currentTimeRaw)
        
        let timeComponents = currentTimeString.split(separator: ":") // timeCompontents 10:10 중 :을 기준으로 앞-시간, 뒤-분으로 분리
        guard let hour = Int(timeComponents.first ?? "")
        else {
            return
        }
            
        switch hour {
            case 3..<6:
                currentTime = "Sunrise"
            case 6..<12:
                currentTime = "Morning"
            case 12..<17:
                currentTime = "Afternoon"
            case 17..<19:
                currentTime = "Sunset"
            case 19..<21:
                currentTime = "Evening"
            default:
                // Night: 21:00-2:59 and 0:00-2:59 (next day)
                currentTime = "Night"
        }
    }
}
