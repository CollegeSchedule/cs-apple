import Foundation

extension DateFormatter {
    static let WEEK_DAY_FORMATTER: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMMM yyyy, EEEE"
        
        return formatter
    }()
    
    static let HOUR_MINUTE_FORMATTER: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        return formatter
    }()
}
