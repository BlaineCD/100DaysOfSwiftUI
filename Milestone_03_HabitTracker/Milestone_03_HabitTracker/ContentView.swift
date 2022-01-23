//
//  ContentView.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

// MARK: - ContentView

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
                                    .font(.title2.weight(.bold))
                                Text("Streak Count: \(item.count)")
                                    .font(.body.weight(.semibold))
                                    .padding(.bottom, 0.6)
                                Text(item.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: removeHabits)
                }
            }
            .navigationTitle("HabitTrax")
            .toolbar {
                Button {
                    showingAddHabit.toggle()
                } label: {
                    Image(systemName: "plus.diamond.fill")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabit(habits: habits)
            }
        }
    }

    // MARK: Internal

    func removeHabits(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
