//
//  ContentView.swift
//  Milestone_05_NameReminder
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @StateObject var people = People()
    @State private var showingAddPerson = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        showingAddPerson.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.green.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title2)
                            .clipShape(Circle())
                            .padding([.top, .leading])
                    }
                    Spacer()
                }
                List {
                    Section("Friends") {
                        ForEach(people.people) { person in
                            Text(person.name)
                        }
                    }
                }
            }
            .navigationTitle("RememberMe")
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView(people: people, name: "")
            }
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
