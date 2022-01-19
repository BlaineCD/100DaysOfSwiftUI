//
//  CustomViews.swift
//  Project_08_Moonshot
//
//  Created by Blaine Dannheisser on 1/18/22.
//

import Foundation
import SwiftUI

// Challenge 2:
// Views for ContentView
struct GridBadge: View {
    var badge: String
    
    var body: some View {
        Image(badge)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding()
    }
}

struct ListBadge: View {
    var badge: String
    
    var body: some View {
        Image(badge)
            .resizable()
            .scaledToFit()
            .frame(width: 125, height: 125)
            .padding()
    }
}

struct MissionTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
    }
}

struct DateTitle: View {
    var date: String
    
    var body: some View {
        Text(date)
            .font(.caption)
            .foregroundColor(.white.opacity(0.5))
    }
}

struct MissionDateLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
    }
}

struct MissionInfoFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
    }
}

// Views for MissionView

struct MissionBadge: View {
    var badge: String
    
    var body: some View {
        Image(badge)
            .resizable()
            .scaledToFit()
            .padding(.top)
            .padding(.bottom)
    }
}

struct LaunchDateTitle: View {
    var launchTitle: String
    
    var body: some View {
        Text("Launched On: \(launchTitle)")
            .font(.title2.bold())
            .padding(.bottom, 5)
    }
}

struct MissionDetails: View {
    var headline: String
    var missionDetails: String
    
    var body: some View {
        VStack {
            Text(headline)
                .font(.title.bold())
                .padding(.bottom, 5)
            Text(missionDetails)
        }
    }
}

struct AstronautImage: View {
    var astroImage: String
    
    var body: some View {
        Image(astroImage)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .strokeBorder(.white, lineWidth: 2)
            )
    }
}

struct AstronautDetails: View {
    var astroName: String
    var astroBio: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(astroName)
                .foregroundColor(.white)
                .font(.headline)
            Text(astroBio)
                .foregroundColor(.secondary)
        }
    }
}

struct RectangleSpacer: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}
