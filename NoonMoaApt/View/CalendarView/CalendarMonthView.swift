//
//  CalendarMonthView.swift
//  MangMong_Calendar_Sample
//
//  Created by kimpepe on 2023/07/19.
//

import SwiftUI
import SwiftUICalendar

struct CalendarMonthView: View {
    @ObservedObject var controller: CalendarController = CalendarController()
    
    let monthMap: [String: String] = [ // 해나 - 영어 월별 이름을 한글로 바꾸기
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

    func getKoreanWeekdayString(_ weekday: String) -> String { // 해나 - 영어 요일을 한글로 바꾸는 함수
        switch weekday {
        case "Sun":
            return "일"
        case "Mon":
            return "월"
        case "Tue":
            return "화"
        case "Wed":
            return "수"
        case "Thu":
            return "목"
        case "Fri":
            return "금"
        case "Sat":
            return "토"
        default:
            return ""
        }
    }
    
    @Binding var isCalendarOpen: Bool
    
    var body: some View {
       
            NavigationView {
                GeometryReader { reader in
                    ZStack {
                        VStack {
                            HStack(alignment: .center) {
                                // 이전 달로 스크롤하는 버튼
                                Button(action: {
                                    controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                                }) {
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                                // 현재 년도와 달을 표시하는 텍스트 뷰
                                Text("\(String(controller.yearMonth.year))년 \(monthMap[controller.yearMonth.monthShortString] ?? "")")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Spacer()
                                // 다음 달로 스크롤하는 버튼
                                Button(action: {
                                    controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                                }) {
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.top, reader.size.width * 0.04)
                            .padding(.horizontal, reader.size.width * 0.02)
                            
                            // 월간 캘린더 뷰
                            CalendarView(controller, header: { week in
                                GeometryReader { geometry in
                                    Text(getKoreanWeekdayString(week.shortString))
                                        .bold(true)
                                        .foregroundColor(.systemGray)
                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                }
                            }, component: { date in
                                GeometryReader { geometry in
                                    if date.isFocusYearMonth! {
                                        NavigationLink(destination: CalendarDayView(controller: CalendarDayController(date))) {
                                            // 클릭된 날짜로 DayCalendarController를 초기화하는 NavigationLink
                                            ZStack {
                                                // MARK: - 월간 달력 요소 UI 작업
                                                // 여기에서 작업하면, 달력의 각 날짜 위치에 그려짐.
                                                
                                                Text("\(date.day)")
                                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                                    .font(.system(size: 16, weight: .light, design: .default))
                                                    .foregroundColor(.systemGray)
                                                    .opacity(date.isFocusYearMonth == true ? 1 : 0)
                                                Circle() // 점선 테두리
                                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                                                    .foregroundColor(.systemGray)
                                                    .padding(1)
                                                
                                                let calendar = Calendar.current
                                                let components = DateComponents(year: date.year, month: date.month, day: date.day) // YearMonthDay 객체에서 년/월/일을 가져와 DateComponents로 변환
                                                if let convertedDate = calendar.date(from: components) {
                                                    if isToday(date: convertedDate) {
//                                                        StampButtons()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            })
//                            .padding(.horizontal, reader.size.width * 0.06)
                        }
                        .background( // 배경 blur
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .opacity(0.01)
                                .background(.regularMaterial)
                        )
                        // MARK: - 달력 전체의 padding을 조절하는 변수
                        .padding(.horizontal, 15)
                    }
                    
                }
                .onChange(of: controller.yearMonth) { yearMonth in
                    print(yearMonth)
                }
            }
    }
}

// 해나 - 오늘 날짜인지를 알려주는 함수 (오늘 & 오늘보다 이전 날짜인지를 알려주는 함수)
func isToday(date: Date) -> Bool {
    let today = Calendar.current.startOfDay(for: Date())
    // return date <= today
    return date == today
}

struct CalendarCustomView_Previews: PreviewProvider {
    static var previews: some View {
        // 2023년 7월을 가진 컨트롤러를 이용해 미리보기를 생성합니다.
        CalendarMonthView(controller: CalendarController(YearMonth(year: 2023, month: 7)), isCalendarOpen: .constant(false))
    }
}
