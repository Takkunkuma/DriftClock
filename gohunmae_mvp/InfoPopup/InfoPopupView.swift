//
//  InfoPopupView.swift
//  gohunmae_mvp
//
//  Created by Tatsuo Kumamoto on 5/10/25.
//

import SwiftUI

struct InfoPopupView: View {
    
    var body: some View {
        Text("What's this app for?")
            .font(.title)
        Text("We want to solve the issue of tardiness")
            .font(.title2)
        Text("You have the magical power to forward your time in this app. You might ask \"why would you want to do that?\" Well, we don't know... but we might find out someday. We think the illusion might help you be on time to your next meetup or hangout! We believe that no one really wants to be late to things and that there exists some way that might be able to help.")
            .padding()
        Text("How to use this app")
            .font(.title)
        Text("Click on the triangle button to pull up the bottom menu. Pick the desire amount of time by scrolling on the number options vertically, then click start to move your time by the quantity you selected. You can change the view of time by selecting the options next to info icon.")
            .padding()
        Text("How you can help us")
            .font(.title)
        Text("We need your feedback! Any feedback is good!")
            .padding()
        
        Text("Pull this menu down to exit!")
            .font(.caption)
            .padding()
    }
}
