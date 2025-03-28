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
                Spacer()
                Text(timeString)
                    .font(.system(size: 68, weight: .bold))
                    .onReceive(timer){ timeNow in
                        let futureDate = timeNow.addingTimeInterval(Double(delay)! * 60) // Add 5 seconds
                        timeString = timeController.getTimeString(date: futureDate)
                    }
                Spacer()
                Picker("Choose Time to Delay", selection: $delay) {
                    ForEach(timeController.getTimeChoices(), id: \.self) {
                        Text($0.description)
                    }
                }
                .pickerStyle(.wheel)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Start!")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity) // Makes the button stretch horizontally
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                })
                .padding(.horizontal, 40)
                .shadow(color: .gray.opacity(0.6), radius: 5, x: 0, y: 5)
//                NavigationLink(destination: SettingView(), isActive: $isShowingTimeView ) {
//                    Image(systemName: "gear")
//                        .foregroundStyle(Color(UIColor(named: "IconColor")!))
//                }
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    TimeView()
}
