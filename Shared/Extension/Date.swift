import Foundation
import SwiftUI

extension Date {
	
	func scheduleTimeline() -> [String] {
		let first = Date().startOfWeek
		let form = DateFormatter()
		form.dateFormat = "dd MMMM"
		
		return (1...14).map { index in
			form.string(from:Calendar.current.date(byAdding: .day, value: index, to: first)!)
		}
	}
	
	var startOfWeek: Date {
		let calendar = Calendar.init(identifier: .gregorian)
		
		return calendar.date(
			from: calendar.dateComponents(
				[
					.yearForWeekOfYear,
					.weekOfYear
				],
				from: self)
		)!
	}
	
	var today: String{
		let form = DateFormatter()
		form.dateFormat = "dd MMMM"
		
		return form.string(from: Date())
	}
}
