//
//  ContentView.swift
//  gohunmae_mvp
//
//  Created by Tatsuo Kumamoto on 3/9/25.
//

import SwiftUI

var timeController = TimeController()

struct TimeView: View {
    
    @State private var timeString = timeController.getTimeString(date: Date())
    @State private var delay: String = "0"
    @State private var isShowingTimeView = true
    private var timer = Timer.publish(every: 1, tolerance: 0.2, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(timeString)
                    .font(.system(size: 54, weight: .bold))
                    .onReceive(timer){ timeNow in
                        let futureDate = timeNow.addingTimeInterval(Double(delay)! * 60) // Add 5 seconds
                        timeString = timeController.getTimeString(date: futureDate)
                    }
                
                Picker("Choose Time to Delay", selection: $delay) {
                    ForEach(timeController.getTimeChoices(), id: \.self) {
                        Text($0.description)
                    }
                }
                .pickerStyle(.wheel)
                
                NavigationLink(destination: SettingView(), isActive: $isShowingTimeView ) {
                    Image(systemName: "gear")
                        .foregroundStyle(Color(UIColor(named: "IconColor")!))
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    TimeView()
}
