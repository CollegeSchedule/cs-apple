import Foundation

extension Date {
    static let DAY_IN_WEEK: Date = {
        var date = Date()
        
        date.addTimeInterval(86400 * 7)
        
        return date
    }()
}
