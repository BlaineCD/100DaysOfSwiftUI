//
//  HabitDetail.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

// MARK: - HabitDetailView

struct HabitDetailView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var habits: Habits
    @State var selectedHabit: Habit
    @State var date = Date.now
    @State private var note = ""

    var body: some View {
        VStack {
            Text(selectedHabit.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)

            HStack {
                TextField("Enter Notes", text: $note)
                    .padding()
                Button {
                    selectedHabit.count += 1
                    addNote()
                    updateHabit()
                    note = ""
                    print(selectedHabit.dates)
                } label: {
                    Image(systemName: "plus.circle")
                        .padding(.trailing)
                }
            }

            List {
                Section("Completed:") {
                    ForEach(Array(zip(selectedHabit.notes, selectedHabit.dates)), id: \.0) { note, date in
                        Text("\(note) \n \(date.formatted(date: .abbreviated, time: .shortened))")
                    }
                    .onDelete(perform: removeHabits)
                }
            }
            Spacer()
                .navigationTitle(selectedHabit.name)
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

    func addNote() {
        guard let index = habits.items.firstIndex(where: { $0.id == selectedHabit.id }) else { return }
        withAnimation {
            habits.items[index].dates.insert(date, at: 0)
            selectedHabit.dates.insert(date, at: 0)
            habits.items[index].notes.insert(note, at: 0)
            selectedHabit.notes.insert(note, at: 0)
        }
    }

    func removeHabits(at offsets: IndexSet) {
        selectedHabit.dates.remove(atOffsets: offsets)
    }
}

// MARK: - HabitDetail_Previews

struct HabitDetail_Previews: PreviewProvider {
    static var previews: some View {
        let habit = Habit(name: "TEST", description: "TEST", notes: [""], count: 5, color: "red")
        HabitDetailView(habits: Habits(), selectedHabit: habit)
    }
}
