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
    @State private var isSlidDown = true
    @State private var rotationAngle: Double = 180
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
                ZStack(alignment: .topTrailing){
                    VStack{
                        Picker("Choose Time to Delay", selection: $delay) {
                            ForEach(timeController.getTimeChoices(), id: \.self) {
                                Text($0.description)
                            }
                        }
                        .padding(20)
                        .pickerStyle(.wheel)
                        .frame(width: 300, height: 150)
                        .clipped()
                        
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
                        .padding(20)
                        .frame(width: 275)
                        .shadow(color: .gray.opacity(0.6), radius: 5, x: 0, y: 5)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.black, lineWidth: 2)
                            .background(Color.white)
                            .cornerRadius(10)
                    )
                    
                    
                    Button(action: {
                        withAnimation {
                            isSlidDown.toggle()
                            rotationAngle -= 180
                        }
                    }) {
                        ZStack {
                                Image("black_triangle")
                                    .rotationEffect(Angle(degrees: rotationAngle))
                            }
                        .offset(x: 10, y: -10)
                    }
                }
                .offset(y: isSlidDown ? 260 : 0) // <-- Move it down when toggled
                .animation(.easeInOut, value: isSlidDown)
            }
        }
    }
}

#Preview {
    TimeView()
}
