struct ScheduleSubjectEntity: Codable, Hashable {
    let id: Int
    let day: Int
    let sort: Int
    
    let teacher: AccountEntity
    let subject: SubjectEntity
    let group: GroupEntity
    let classroom: ClassroomEntity
}
