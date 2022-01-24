//
//  HabitDetail.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var habits: Habits
    @State var selectedHabit: Habit
    @State var date = Date.now

    var body: some View {
        VStack {
            List {
                Section("Completed:") {
                    ForEach(selectedHabit.dates, id: \.self) { date in
                        Text("\(date.formatted(date: .abbreviated, time: .shortened))")
                    }
                }
            }
            Button(action: {
                selectedHabit.count += 1
                addNewDate()
                updateHabit()
            }, label: {
                Text("ADD")
                    .foregroundColor(.white)
                    .frame(width: 280, height: 80)
                    .background(.green)
                    .padding()
            })
            Spacer()
                .navigationTitle("\(selectedHabit.name) Streak: \(selectedHabit.count)")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                    }
                }
        }
    }

    // MARK: Internal

    func updateHabit() {
        guard let index = habits.items.firstIndex(where: { $0.id == selectedHabit.id }) else { return }
        habits.items[index].count = selectedHabit.count
    }

    func addNewDate() {
        guard let index = habits.items.firstIndex(where: { $0.id == selectedHabit.id }) else { return }
        withAnimation {
            habits.items[index].dates.insert(date, at: 0)
            selectedHabit.dates.insert(date, at: 0)
        }
    }
}


struct HabitDetail_Previews: PreviewProvider {
     static var previews: some View {
         let habit = Habit(name: "TEST", description: "TEST", count: 5)
         HabitDetailView(habits: Habits(), selectedHabit: habit)
     }
 }
