struct ScheduleSubjectEntity: Codable, Hashable {
    let id: Int
    var day: Int
    let sort: Int
    
    let time: ScheduleSubjectTimeEntity
    let teacher: AccountEntity
    let subject: SubjectEntity
    let group: GroupEntity
    let classroom: ClassroomEntity
}
