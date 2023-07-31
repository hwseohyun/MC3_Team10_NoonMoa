//
//  CalendarGridView.swift
//  MangMong_Calendar_Sample
//
//  Created by kimpepe on 2023/07/19.
//

import SwiftUI

// 캘린더의 그리드 뷰 구조체
struct CalendarGridView: View {
    @Binding var currentDate: Date  // 현재 날짜
    
    // MARK: - Divider

    var body: some View {
        VStack(spacing: 10) {  // 주를 세로로 나열
            ForEach(0..<numberOfWeeks(), id: \.self) { weekIndex in  // 각 주에 대한 뷰 생성
                WeekView(weekIndex: weekIndex, currentDate: $currentDate)
            }
        }
        .padding()  // 패딩 추가
    }

    // 달에 있는 주의 개수를 계산하는 함수
    private func numberOfWeeks() -> Int {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .weekOfMonth, in: .month, for: currentDate)
        return monthRange?.count ?? 0
    }
}

struct CalendarGridView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGridView(currentDate: .constant(Date()))
    }
}
