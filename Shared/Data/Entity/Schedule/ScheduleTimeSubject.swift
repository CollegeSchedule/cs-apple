struct ScheduleTimeSubject: Codable {
    let weekdays: [Lesson]
    let weekends: [Lesson]
    
    struct Lesson: Codable {
        let startTime: Int
        let lengthTime: Int
    }
}
