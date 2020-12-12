import Foundation

extension DateFormatter {
    static let WEEK_DAY_FORMATTER: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMMM yyyy, EEEE"
        
        return formatter
    }()
}
