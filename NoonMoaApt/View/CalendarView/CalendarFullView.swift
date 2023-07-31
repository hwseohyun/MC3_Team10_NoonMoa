//
//  CalendarFullView.swift
//  MangMongApt
//
//  Created by kimpepe on 2023/07/17.
//

import SwiftUI
import SwiftUICalendar
import Firebase
import FirebaseFirestore

class CalendarFullViewModel: ObservableObject {
    @Published var attendanceRecords: [AttendanceRecord] = []
    @Published var monthToShow: Date = Date()
    @Published var selectedRecord: AttendanceRecord? = nil
    @Published var selectedDate: Date? = nil  // add this line
    
    private var firestoreManager: FirestoreManager {
        FirestoreManager.shared
    }
    private var db: Firestore {
        firestoreManager.db
    }
    
    init() {
        fetchUserAttendanceRecords()
    }

    func fetchUserAttendanceRecords() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let docRef = db.collection("AttendanceSheet").document(userId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let attendanceSheet = try? document.data(as: AttendanceSheet.self)
                if let recordIds = attendanceSheet?.attendanceRecords {
                    self.fetchAttendanceRecords(recordIds: recordIds)
                }
            }
        }
    }
    
    private func fetchAttendanceRecords(recordIds: [String]) {
        let recordRef = db.collection("AttendanceRecord")
        recordIds.forEach { id in
            recordRef.document(id).getDocument { (recordDocument, recordError) in
                if let recordDocument = recordDocument, recordDocument.exists {
                    if let record = try? recordDocument.data(as: AttendanceRecord.self) {
                        DispatchQueue.main.async {
                            self.attendanceRecords.append(record)
                        }
                    }
                }
            }
        }
    }
    
    func record(for date: Date) -> AttendanceRecord? {
        let calendar = Calendar.current
        return attendanceRecords.first { record in
            let recordDate = calendar.startOfDay(for: record.date)
            let targetDate = calendar.startOfDay(for: date)
            return recordDate == targetDate
        }
    }
}

struct CalendarFullView: View {
    @StateObject var viewModel = CalendarFullViewModel()
    @ObservedObject var controller: CalendarController = CalendarController()
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack {
                    HStack(alignment: .center, spacing: 0) {
                        Button("Prev") {
                            controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                        }
                        .padding(8)
                        Spacer()
                        Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                            .font(.title)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        Spacer()
                        Button("Next") {
                            controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                        }
                        .padding(8)
                    }
                    CalendarView(controller, header: { week in
                        GeometryReader { geometry in
                            Text(week.shortString)
                                .font(.subheadline)
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        }
                    }, component: { yearMonthDay in
                        GeometryReader { geometry in
                            Button(action: {
                                viewModel.selectedDate = yearMonthDay.date  // set selectedDate in viewModel regardless of the record
                            }) {
                                if let recordDate = yearMonthDay.date, let record = viewModel.record(for: recordDate) {
                                    ZStack {
                                        if yearMonthDay.isToday {
                                            Circle()
                                                .padding(4)
                                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                                .foregroundColor(.orange)
                                        }
                                        VStack {
                                            Text("\(yearMonthDay.day)")
                                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                                .font(.system(size: 10, weight: .light, design: .default))
                                            Text("\(record.rawWeather)")
                                                .font(.system(size: 10, weight: .light, design: .default))
                                            Text("\(record.rawLookAtPoint.map{ String($0) }.joined(separator: ", "))")
                                                .font(.system(size: 10, weight: .light, design: .default))
                                        }
                                    }
                                } else {
                                    // Display empty or default view
                                    Text("\(yearMonthDay.day)")
                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                        .font(.system(size: 10, weight: .light, design: .default))
                                }
                            }
                        }
                    })
                }
            }
            .onChange(of: controller.yearMonth) { yearMonth in
                print(yearMonth)
            }
            .navigationBarTitle("Embed header")
            .background(
                // Use NavigationLink here
                NavigationLink(
                    destination: Group {
                        // Extract date components
                        if let selectedDate = viewModel.selectedDate {
                            let components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
                            let yearMonthDay = YearMonthDay(year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0)
                            
                            // Create CalendarSingleController with extracted date
                            CalendarSingleView(controller: CalendarSingleController(yearMonthDay, viewModel: viewModel))
                        }
                    },
                    isActive: Binding<Bool>(
                        get: { viewModel.selectedDate != nil },
                        set: { _ in viewModel.selectedDate = nil }
                    ),
                    label: {
                        EmptyView()
                    }
                )
            )
        }
    }
}

struct CalendarFullView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarFullView()
    }
}

extension DateFormatter {
    static let monthAndYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}
