//
//  Facility.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/11/22.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    let name: String

    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3"
    ]

    var icon: some View {
        if let iconName = icons[name] {
            return Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundColor(.blue)
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }

    private let descriptions = [
        "Accommodation": "This resort has popular on-site accommodations.",
        "Beginners": "This resort has lots of ski schools and is good for beginners.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort has won an award for environmental friendliness.",
        "Family": "This resort is popular with families."
    ]

    var descripion: String {
        if let message = descriptions[name] {
            return message
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
}
