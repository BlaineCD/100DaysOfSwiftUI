//
//  ContentView.swift
//  Project_16_HotProspects
//
//  Created by Blaine Dannheisser on 3/23/22.
//

import SwiftUI

struct ContentView: View {

    // ProspectsView instances should share a single instance of Prospects class so they point to same data. 1a) Store a single instance of Prospects class:
    @StateObject var prospects = Prospects()

    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        // 2a) Post the property into the environment so that child views can access. Tabs are children of the tab view they are inside so we add it to the enviornment for TabView so all ProspectView instances get the object.
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
