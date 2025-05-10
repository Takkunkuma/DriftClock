//
//  TimeModel.swift
//  gohunmae_mvp
//
//  Created by Tatsuo Kumamoto on 3/11/25.
//

import Foundation
import Combine

class SettingModel: ObservableObject {
    @Published var selectedDelay: Int = 5 // Default value

    // Store selected value in UserDefaults for persistence
    init() {
        self.selectedDelay = UserDefaults.standard.integer(forKey: "selectedDelay")
    }

    func saveSelectedNumber(_ number: Int) {
        selectedDelay = number
        UserDefaults.standard.set(number, forKey: "selectedDelay")
    }
}
