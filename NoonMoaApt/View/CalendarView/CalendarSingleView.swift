//
//  CalendarSingleView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/17.
//

import SwiftUI
import SwiftUICalendar
import Firebase

struct CalendarSingleView: View {
    @ObservedObject var controller: CalendarSingleController = CalendarSingleController(viewModel: CalendarFullViewModel())

    var body: some View {
        GeometryReader { reader in
            VStack {
                HStack(alignment: .center, spacing: 0) {
                    Button("Prev") {
                        controller.setYearMonthDay(controller.yearMonthDay.addDay(value: -1))
                    }
                    .padding(8)
                    Spacer()
                    Text("\(controller.yearMonthDay.day), \(controller.monthShortString), \(String(controller.yearMonthDay.year))")
                        .font(.title)
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    Spacer()
                    Button("Next") {
                        controller.setYearMonthDay(controller.yearMonthDay.addDay(value: 1))
                    }
                    .padding(8)
                }
                if let record = controller.record {
                    Text("Weather condition: \(record.rawWeather)")
                    Text("Eye Direction: \(record.rawLookAtPoint.map{ String($0) }.joined(separator: ", "))")
                }
                // The rest of your code...
            }
        }
        // The rest of your code...
    }
}

struct CalendarSingleView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSingleView()
    }
}
