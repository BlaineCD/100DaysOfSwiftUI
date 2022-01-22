//
//  AddHabit.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

struct AddHabit: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("New Habit", text: $name)
                    TextField("Description", text: $description)
                        .frame(height: 100)
                }
                Button {
                    let habit = Habit(name: name, description: description)
                    habits.items.append(habit)
                    dismiss()
                } label: {
                    Text("SUBMIT")
                        .foregroundColor(.white)
                        .frame(width: 280, height: 80)
                        .background(.green)
                        .padding()
                }
                Spacer()

                    .navigationTitle("Add New Habit")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
