import SwiftUI

struct ScheduleLessonView: View {
    @EnvironmentObject var settings: CollegeSchedule.SettingsModel
    
    private var item: ScheduleSubjectEntity? = nil
    private var mode: SchedulePresentationMode
    private var sheetAllowed: Bool
    
    @State var isPresented: Bool = false
    
    init(item: ScheduleSubjectEntity?, mode: SchedulePresentationMode, sheetAllowed: Bool = true) {
        self.item = item
        self.mode = mode
        self.sheetAllowed = sheetAllowed
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if self.settings.lessonShowSort {
                VStack {
                    if self.item != nil {
                        Text("\(self.item!.sort)")
                    }
                }.frame(width: 20, alignment: .leading)
            }
            
            if self.settings.lessonShowTime {
                VStack {
                    if self.item != nil {
                        Text(self.hoursTime(time: self.item!.time.start))
                        Text(self.hoursTime(time: self.item!.time.start + self.item!.time.length))
                    }
                }.frame(width: 50, alignment: .leading)
            }
            
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8).foregroundColor(.orange).frame(maxWidth: 4, maxHeight: 40)
                    .padding(.horizontal, 8)
            }

            if self.item != nil {
                VStack(alignment: .leading) {
                    Text(self.item!.subject.name).truncationMode(.tail).lineLimit(1)
                    Text(self.mode == .student ? self.item!.teacher.print : self.item!.group.print!)
                        .truncationMode(.tail).foregroundColor(.gray).lineLimit(1)
                }
                
                Spacer()
                
                Text(self.item!.classroom.name)
            } else {
                Text("Пустая пара")
            }
        }
        .applyIf(self.item != nil) {
            $0.onTapGesture {
                self.isPresented = true
            }.sheet(isPresented: self.$isPresented) {
                NavigationView {
                    List {
                        HStack {
                            Text("authenticated.schedule.lesson.sheet.field.subject")
                            Spacer()
                            Text(self.item!.subject.name).foregroundColor(.gray).multilineTextAlignment(.trailing)
                        }
                        
                        if self.sheetAllowed {
                            NavigationLink(destination: self.scheduleDestination) {
                                self.scheduleLabel
                            }
                        } else {
                            self.scheduleLabel
                        }
                        
                        HStack {
                            Text("authenticated.schedule.lesson.sheet.field.cabinet")
                            Spacer()
                            Text(self.item!.classroom.name).foregroundColor(.gray)
                        }
                    }
                    .navigationTitle(Text("authenticated.schedule.lesson.sheet.title"))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: self.closeSheet) {
                        Text("base.done")
                    })
                }
            }
        }
    }
        
    private var scheduleDestination: some View {
        if self.mode == .student {
            return ScheduleComponentView(accountId: self.item!.teacher.id, mode: .teacher, sheetAllowed: false)
                .navigationTitle(self.item!.teacher.print)
                .modifier(BackgroundModifier(color: .scheduleSheetSectionListColor))
                .ignoresSafeArea(SafeAreaRegions.all, edges: .bottom)
                .eraseToAnyView()
        } else {
            return ScheduleComponentView(groupId: self.item!.group.id, mode: .student, sheetAllowed: false)
                .navigationTitle(self.item!.group.print!)
                .modifier(BackgroundModifier(color: .scheduleSheetSectionListColor))
                .ignoresSafeArea(SafeAreaRegions.all, edges: .bottom)
                .eraseToAnyView()
        }
    }
    
    private var scheduleLabel: some View {
        HStack {
            Text(
                self.mode == .student
                    ? "authenticated.schedule.lesson.sheet.field.teacher"
                    : "authenticated.schedule.lesson.sheet.field.group"
            )
            Spacer()
            Text(self.mode == .student ? self.item!.teacher.print: self.item!.group.print!)
                .foregroundColor(.gray)
        }.eraseToAnyView()
    }
    
    private func closeSheet() {
        self.isPresented = false
    }
    
    private func hoursTime(time: Int) -> String {
        return DateFormatter.HOUR_MINUTE_FORMATTER.string(from: TimeInterval(time * 60))!
    }
}
