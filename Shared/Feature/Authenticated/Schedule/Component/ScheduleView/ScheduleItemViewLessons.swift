//
//  ScheduleItemViewLessons.swift
//  iOS
//
//  Created by admin on 18.12.2020.
//

import SwiftUI

struct ScheduleItemViewLessons: View {
    @State
    var day: ScheduleView.WeekDay
    @State
    var item: [ScheduleSubjectEntity]
    @State
    var isTeacher: Bool
    @State
    var weekdays: ScheduleTimeSubject
    
    var body: some View {
        ForEach(
            item,
            id: \.id
        ) { item in
            ScheduleItemView(
                item: item,
                isTeacher: self.isTeacher,
                weekdays: self.day.id == 6
                    ? (item.sort - 1 < self.weekdays.weekends.count ? self.weekdays.weekends[item.sort - 1] : nil)
                    : (item.sort - 1 < self.weekdays.weekdays.count ? self.weekdays.weekdays[item.sort - 1] : nil)
            )
            .listRowBackground(Color.scheduleRowListColor)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
