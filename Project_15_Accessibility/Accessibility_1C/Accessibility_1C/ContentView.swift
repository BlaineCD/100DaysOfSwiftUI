//
//  ContentView.swift
//  Accessibility_1C
//
//  Created by Blaine Dannheisser on 3/15/22.
// REading the value of controls

import SwiftUI

struct ContentView: View {

    @State private var value = 10

    var body: some View {
        VStack {
            // VoiceOver would only read "Increment or Decrement, and not the updated value"
            Text("Value: \(value)")
            Button("Increment") {
                value += 1
            }

            Button("Decrement") {
                value -= 1
            }
        }
        //Group VStack to respo0nd to swipes with custom code. This alllows for swiping up or down to manipulate the value and have only the numbers read out. 
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
