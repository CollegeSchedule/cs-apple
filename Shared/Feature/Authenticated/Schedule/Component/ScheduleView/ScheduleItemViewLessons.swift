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
                weekdays:
                    day.id == 6
                    ? weekdays.weekends[item.sort - 1]
                    : weekdays.weekdays[item.sort - 1]
            )
            .listRowBackground(Color.scheduleRowListColor)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
