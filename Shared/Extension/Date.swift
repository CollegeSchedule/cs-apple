import Foundation

extension Date {
    static let DAY_IN_WEEK: Date = {
        Date().addingTimeInterval(86400 * 7)
    }()
    
    static let TOMORROW: Date = {
        Date().addingTimeInterval(86400)
    }()
    
    static let YESTERDAY: Date = {
        Date().addingTimeInterval(-86400)
    }()
}
