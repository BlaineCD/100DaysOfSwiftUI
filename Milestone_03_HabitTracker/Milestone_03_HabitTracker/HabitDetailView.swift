//
//  HabitDetail.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment (\.dismiss) var dismiss

    @ObservedObject var habits: Habits
    @State var selectedHabit: Habit
  

    var body: some View {
        List {
            Section("\(selectedHabit.description)") {
            Text("\(selectedHabit.count)")
            }
        }
        .navigationTitle("\(selectedHabit.name)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    selectedHabit.count += 1
                    updateHabit()
                } label: {
                    Text("Add")
                    }
                }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }

    func updateHabit() {
        guard let index = habits.items.firstIndex(where: { $0.id == selectedHabit.id }) else { return }
        habits.items[index].count = selectedHabit.count
    }
}

//struct HabitDetail_Previews: PreviewProvider {
//
//    static var previews: some View {
//        HabitDetailView(habits: Habit(name: "TEST", description: "TEST", count: 5), selectedHabit: "")
//    }
//}
