//
//  CalendarDayView.swift
//  MangMong_Calendar_Sample
//
//  Created by kimpepe on 2023/07/19.
//
////

import SwiftUI
import SwiftUICalendar

// 일자를 조작하는 클래스
public class CalendarDayController: ObservableObject {
    // 현재 날짜를 가지고 있는 Published 변수
    @Published public var yearMonthDay: YearMonthDay
    public var calendarController: CalendarController

    // 생성자, 기본값은 현재 날짜, 기본 방향은 수평, 기본 잠금 상태는 잠기지 않음
    public init(_ yearMonthDay: YearMonthDay = .current, orientation: Orientation = .horizontal, isLocked: Bool = false) {
        self.yearMonthDay = yearMonthDay
        self.calendarController = CalendarController(YearMonth(year: yearMonthDay.year, month: yearMonthDay.month), orientation: orientation, isLocked: isLocked)
    }

    // 새로운 년, 월, 일로 설정하는 함수
    public func setYearMonthDay(_ yearMonthDay: YearMonthDay) {
        self.yearMonthDay = yearMonthDay
        self.calendarController.setYearMonth(year: yearMonthDay.year, month: yearMonthDay.month)
    }

    // 현재 달을 문자열로 반환하는 함수
    public var monthShortString: String {
        let yearMonth = YearMonth(year: yearMonthDay.year, month: yearMonthDay.month)
        return yearMonth.monthShortString
    }
}

// Day Calendar View
struct CalendarDayView: View {
    @ObservedObject var controller: CalendarDayController = CalendarDayController()

    func getKoreanMonthString(_ monthAbbreviation: String) -> String {
        let monthMap: [String: String] = [
            "Jan": "1월",
            "Feb": "2월",
            "Mar": "3월",
            "Apr": "4월",
            "May": "5월",
            "Jun": "6월",
            "Jul": "7월",
            "Aug": "8월",
            "Sep": "9월",
            "Oct": "10월",
            "Nov": "11월",
            "Dec": "12월"
        ]
        
        return monthMap[monthAbbreviation] ?? ""
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    // 선택한 날짜를 표시하는 텍스트 뷰
                    Text("\(String(controller.yearMonthDay.year))년 \(getKoreanMonthString(controller.monthShortString)) \(controller.yearMonthDay.day)일")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    Spacer()
                }
                // MARK: - 일간 달력 요소 UI 작업
                // 여기에서 작업하면, 달력의 각 날짜 위치에 그려짐.
                
//                StampLDesign(isAttendanceView: false, isStamped: true)
            }
        }
    }
}

struct DayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        // 2023년 7월 17일을 가진 컨트롤러를 이용해 미리보기를 생성합니다.
        CalendarDayView(controller: CalendarDayController(YearMonthDay(year: 2023, month: 7, day: 17)))
    }
}
