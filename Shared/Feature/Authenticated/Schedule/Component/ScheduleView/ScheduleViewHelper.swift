import SwiftUI

extension ScheduleView {
   static let WEEK_DAY_FORMATTER: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EE"
        
        return formatter
    }()
    
    static let MONTH_DAY_FORMATTER: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd"
        
        return formatter
    }()
    
}
