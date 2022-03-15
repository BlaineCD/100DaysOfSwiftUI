//
//  ContentView.swift
//  Accessibility_1B
//
//  Created by Blaine Dannheisser on 3/15/22.
// Hiding and grouping accessbility data

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        // Tells VoiceOver to ignore particular UI that is decorative. Will still read traits i.e. button or image
        Image(decorative: "cactus")
            // Goes a step further to make view completely invisibly to accessibility. Will hide traits
                .accessibilityHidden(true)

            // Grouping - How the system reads related views. VO sees below as two unrelated views.
            VStack {
            Text("Your Plant is")
            Text("Cactus")
                .font(.title)
            }
            // Apply to parent view and combine children into a single accessbility element. Will cause views to be read together. This is best when views contain separate info
//            .accessibilityElement(children: .combine)

            // Better is to use below so that child views are invisible to VO and then provide custom label to the parent.
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your plant is cactus")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
