//
//  TimeController.swift
//  gohunmae_mvp
//
//  Created by Tatsuo Kumamoto on 3/11/25.
//

import Foundation

enum TimeFormat: String, CaseIterable, Identifiable {
    case twelveHour = "h:mm a"
    case twentyFourHour = "HH:mm"

    var id: String { self.rawValue }

    var description: String {
        switch self {
        case .twelveHour: return "12-hour"
        case .twentyFourHour: return "24-hour"
        }
    }

    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = self.rawValue
        return formatter
    }
}

class TimeController {
    
    private let delayOptions = ["0", "1", "5", "10", "20", "30"]
    let twelveHourFormat = "h:mm a"
    let twentyFourHourFormat = "HH:mm:ss"

    
    func getTimeChoices() -> [String] {
        return delayOptions
    }
    
    func getFormatOptions() -> [TimeFormat] {
            return TimeFormat.allCases
        }
    
    func getFormattedTime(for date: Date, using format: TimeFormat) -> String {
        return format.formatter.string(from: date)
    }
    
    func getAdjustedTime(from date: Date, delay: String) -> Date {
        guard let delayMinutes = Double(delay) else { return date }
        let date = date.addingTimeInterval(delayMinutes * 60)
        return date
    }

}
