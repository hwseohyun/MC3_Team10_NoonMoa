//
//  MonthView.swift
//  MangMong_Calendar_Sample
//
//  Created by kimpepe on 2023/07/19.
//

import SwiftUI

// 한 달을 표시하는 뷰 구조체
struct MonthView: View {
    @Binding var currentDate: Date  // 현재 날짜
    let daysInWeek = 7
    var dummyData: [String] // 예시 데이터

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(0..<numberOfWeeks(in: currentDate), id: \.self) { week in  // 각 주에 대한 뷰 생성
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<daysInWeek, id: \.self) { day in  // 각 요일에 대한 뷰 생성
                        VStack {
                            Text("\(dayOfWeek(for: day, in: week, of: currentDate))")
                            Text(dummyData[day % dummyData.count])
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }

    // 주의 개수를 계산하는 도우미 함수
    func numberOfWeeks(in date: Date) -> Int {
        return 4  // 간단히, 모든 달은 4주로 가정
    }

    // 주어진 날짜에 대한 요일을 계산하는 도우미 함수
    func dayOfWeek(for day: Int, in week: Int, of date: Date) -> Int {
        return 1 + day + week * daysInWeek  // 간단히, 월의 첫 날은 일요일(요일 1)로 가정
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(currentDate: .constant(Date()), dummyData: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
    }
}
