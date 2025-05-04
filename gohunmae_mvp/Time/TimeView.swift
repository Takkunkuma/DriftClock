//
//  ContentView.swift
//  gohunmae_mvp
//
//  Created by Tatsuo Kumamoto on 3/9/25.
//

import SwiftUI

var timeController = TimeController()

struct TimeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var timePostUpdate = timeController.getTimeString(date: Date())
    @State private var timeBeforeUpdate =
        timeController.getTimeString(date: Date())
    
    @State private var delay: String = "0"
    @State private var previousPick: String = "0"
    @State private var rotationAngle: Double = 180
    
    @State private var isShowingTimeView = true
    @State private var isSlidDown = true
    @State private var isPicking = false
    
    private var timer = Timer.publish(every: 1, tolerance: 0.2, on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                ZStack(alignment: .center){
                    Text(timePostUpdate)
                        .font(.system(size: 68, weight: .bold))
                        .onReceive(timer){ timeNow in
                            let futureDate = timeNow.addingTimeInterval(Double(delay)! * 60) // Add 5 seconds
                            timePostUpdate = timeController.getTimeString(date: futureDate)
                        }
                        .padding(.bottom, 100)
                    Text(timeBeforeUpdate)
                        .font(.system(size: 68, weight: .bold))
                        .foregroundColor(isPicking ? .gray : .black)
                        .opacity(isPicking ? 1 : 0)
                        .scaleEffect(isPicking ? 0.6 : 1.0)
                        .offset(y: isPicking ? -75 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isPicking)
                        .onReceive(timer){timeNow in
                            let previousTime = timeNow.addingTimeInterval(Double(previousPick)! * 60)
                            timeBeforeUpdate = timeController.getTimeString(date: previousTime)
                        }
                        .padding(.bottom, 100)
                    }
                
                ZStack(alignment: .topTrailing){
                    VStack{
                        Picker("Choose Time to Delay", selection: $delay.animation()) {
                            ForEach(timeController.getTimeChoices(), id: \.self) {
                                Text($0.description)
                            }
                        }
                        .padding(20)
                        .pickerStyle(.wheel)
                        .frame(width: 300, height: 150)
                        .clipped()
                        .onChange(of: delay) {
                            withAnimation {
                                isPicking = true
                            }
                        }
                        
                        Button(action: {
                            isPicking = false
                            isSlidDown = true
                        }, label: {
                            Text("Start!")
                                .font(.title)
                                .bold()
                                .foregroundStyle(Color("basicColorSet"))
                                .frame(maxWidth: .infinity) // Makes the button stretch horizontally
                                .padding()
                                .background(Color("ButtonColor"))
                                .cornerRadius(15)
                        })
                        .padding(20)
                        .frame(width: 275)
                        .shadow(color: .gray.opacity(0.6), radius: 5, x: 0, y: 5)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color("basicColorSetReversed"), lineWidth: 2)
                            .background(.basicColorSet)
                            .cornerRadius(10)
                    )
                    
                    
                    Button(action: {
                        withAnimation {
                            isSlidDown.toggle()
                            rotationAngle -= 180
                        }
                    })
                    {
                        ZStack {
                            Image("black_triangle")
                                .renderingMode(.template)
                                .rotationEffect(Angle(degrees: rotationAngle))
                                .foregroundStyle(Color("triangleIconColor"))
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
