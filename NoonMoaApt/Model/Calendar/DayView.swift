//
//  DayView.swift
//  MangMong_Calendar_Sample
//
//  Created by kimpepe on 2023/07/19.
//

import SwiftUI

// 하루를 표시하는 뷰 구조체
struct DayView: View {
    let dayIndex: Int  // 날짜 인덱스
    let weekIndex: Int  // 주 인덱스
    @Binding var currentDate: Date  // 현재 날짜

    var body: some View {
        let calendar = Calendar.current
        // 주의 시작 일과 일 인덱스를 사용하여 날짜를 계산
        let date = calendar.date(bySetting: .weekOfMonth, value: weekIndex + 1, of: currentDate)!
            .advanced(by: TimeInterval(dayIndex * 24 * 60 * 60))
        // 날짜가 현재 달인지, 선택된 날짜인지 확인
        let isCurrentMonth = calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
        let isSelectedDate = calendar.isDate(date, equalTo: currentDate, toGranularity: .day)

        // 날짜를 텍스트로 표시하고 선택된 날짜의 경우 파란색으로 하이라이트
        Text(String(calendar.component(.day, from: date)))
            .font(isSelectedDate ? .headline : .body)
            .foregroundColor(isCurrentMonth ? .primary : .secondary)
            .frame(width: 30, height: 30)
            .background(isSelectedDate ? Color.blue : Color.clear)
            .cornerRadius(15)
            .onTapGesture {
                currentDate = date  // 탭할 때 현재 날짜를 이 날짜로 설정
            }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayIndex: 1, weekIndex: 1, currentDate: .constant(Date()))
    }
}





