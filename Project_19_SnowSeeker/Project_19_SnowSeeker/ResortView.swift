//
//  ResortView.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/8/22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize

    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facility?
    @State private var showingFacility = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFill()
                // Challenge 1:
                    .overlay {
                        Text("Photo Credit: \(resort.imageCredit)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(.black.opacity(0.7))
                            .cornerRadius(15)
                            .offset(x: 100, y: 76)
                            .padding()
                    }

                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                    } else {
                    SkiDetailsView(resort: resort)
                    ResortDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.thinMaterial)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)

                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline.bold())
//                    Text(resort.facilities, format: .list(type: .and))
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility.toggle()
                            } label: {
                            facility.icon
                                .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if favorites.contains(resort) {
                           favorites.remove(resort)
                       } else {
                           favorites.add(resort)
                       }
                } label: {
                    Image(systemName: favorites.contains(resort) ? "heart.fill" : "heart")
                }
            }
        }

        .alert(selectedFacility?.name ?? "More Information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.descripion)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
                .environmentObject(Favorites())
        }
    }
}
