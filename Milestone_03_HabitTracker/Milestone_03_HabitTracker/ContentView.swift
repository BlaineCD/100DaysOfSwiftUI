//
//  ContentView.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false

    var body: some View {
        NavigationView {
            List {
                Section("Tracking Habits:") {
                    ForEach(habits.items, id: \.id) { item in
                        NavigationLink {
                            HabitDetailView(habits: habits, selectedHabit: item)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 0.8)
                                Text(item.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: removeHabits)
                }
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                Button {
                    showingAddHabit.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabit(habits: habits)
            }
        }
    }
    
    func removeHabits(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
