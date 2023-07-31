//
//  WeekView.swift
//  MangMong_Calendar_Sample
//
//  Created by kimpepe on 2023/07/19.
//

import SwiftUI

// 한 주를 표시하는 뷰 구조체
struct WeekView: View {
    let weekIndex: Int  // 주 인덱스
    @Binding var currentDate: Date  // 현재 날짜

    var body: some View {
        HStack(spacing: 10) {  // 주를 가로로 나열
            ForEach(0..<7) { dayIndex in  // 각 요일에 대한 뷰 생성
                DayView(dayIndex: dayIndex, weekIndex: weekIndex, currentDate: $currentDate)
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(weekIndex: 1, currentDate: .constant(Date()))
    }
}
