//
//  TimeController.swift
//  gohunmae_mvp
//
//  Created by Tatsuo Kumamoto on 3/11/25.
//

import Foundation

class TimeController {
    
    private let time = ["0", "1", "5", "10"]
    
    func getTimeChoices() -> Array<String> {
        return time
    }
    
    func getTimeString(date: Date) -> String {
        getTimeFormatter().string(from: date)
    }
    
    func getTimeFormatter() -> DateFormatter {
        let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter
    }

}
