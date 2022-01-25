//
//  AddHabit.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

// MARK: - AddHabit

struct AddHabit: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    @State private var selectedColor = "black"
    let colors = ["green", "blue", "purple", "orange", "red", "black"]

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Add New Habit") {
                    TextField("New Habit", text: $name)
                    TextField("Description", text: $description)
                        .frame(height: 100)
                    }

                    Section("Pick Color") {
                        HStack {
                            ForEach(colors, id: \.self) { choice in
                                Button {
                                selectedColor = choice
                                } label: {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(Color(choice))
                                        .padding(12)

                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
                Button {
                    print(selectedColor)
                    if name != "" {
                        let newHabit = Habit(name: name, description: description, count: 0, color: selectedColor)
                    habits.items.append(newHabit)
                    dismiss()
                    }
                } label: {
                    Text("SUBMIT")
                        .foregroundColor(.white)
                        .frame(width: 280, height: 80)
                        .background(.green)
                        .padding()
                }
                Spacer()
                    .navigationTitle("HabitTrax")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

// MARK: - AddHabit_Previews

//struct AddHabit_Previews: PreviewProvider {
//    static var previews: some View {
//        AddHabit(habits: Habits()
//    }
//}
