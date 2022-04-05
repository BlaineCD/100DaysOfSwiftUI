//
//  ContentView.swift
//  Milestone_06_RollTheDice
//
//  Created by Blaine Dannheisser on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false

    var body: some View {
        NavigationView {
            VStack {
                Text("HELLO")
                Text("GOODBYE")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
