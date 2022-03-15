//
//  ContentView.swift
//  Accessibility_1A
//
//  Created by Blaine Dannheisser on 3/15/22.
// Description: Identifying views with useful labels

import SwiftUI

struct ContentView: View {

    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen Tree Buds",
        "Sunflowers",
        "Fireworks"
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
        // Label read immediately - clear and concise.
            .accessibilityLabel(labels[selectedPicture])
        // Identified as image, but it has a tap gesture so it is also a button. This provides extra info to VoiceOver that describes how the view works.
            .accessibilityAddTraits(.isButton)
        // Optional to remove the image trait. VO now reads a description of the image's contents but makes users aware that it is a button. 
            .accessibilityRemoveTraits(.isImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
