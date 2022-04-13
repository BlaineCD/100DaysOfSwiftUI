//
//  ContentView.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/7/22.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    enum SortedBy {
        case alphabetical
        case country
        case normal
    }

    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    @StateObject var favorites = Favorites()

    @State private var sortingStatus = SortedBy.normal
    @State private var showSorting = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorited resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar {
                Button {
                    showSorting.toggle()
                } label: {
                    Text("Sort")
                }
            }
            .confirmationDialog("Sort by...", isPresented: $showSorting) {
                Button("By resort name") { sortingStatus = .alphabetical }
                Button("By country name") { sortingStatus = .country }
                Button("Default order") { sortingStatus = .normal }
            }

            .searchable(text: $searchText, prompt: "Search for a resort")
            WelcomeView()
        }
        .environmentObject(favorites)
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // Challenge 3
    var sortedResorts: [Resort] {
        switch sortingStatus {
        case .alphabetical:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        case .normal:
            return resorts
        }
    }
}

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
