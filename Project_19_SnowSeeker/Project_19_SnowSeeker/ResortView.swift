//
//  ResortView.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/8/22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFill()

                HStack {
                    SkiDetailsView(resort: resort)
                    ResortDetailsView(resort: resort)
                }
                .padding(.vertical)
                .background(.thinMaterial)

                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline.bold())
                    Text(resort.facilities, format: .list(type: .and))
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
        }
    }
}
