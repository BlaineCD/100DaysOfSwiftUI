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
    @State private var selectedColor = ""
    let colors = ["black", "green", "blue", "purple", "orange", "red"]
    @State private var animationAmount = 0.0
    @State private var isClicked = false

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
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    withAnimation {
                                       selectedColor = color
                                    }
                                } label: {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(Color(color))
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .rotation3DEffect(.degrees(selectedColor == color  ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                            }
                        }
                    }
                }
                Button {
                    let newHabit = Habit(name: name, description: description, notes: [""], count: 0, color: selectedColor)
                    habits.items.append(newHabit)
                    dismiss()
                } label: {
                    Text("SUBMIT")
                        .padding()
                        .frame(width: 280, height: 80)
                        .background(.green)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                .disabled(name.isEmpty)

                Spacer()
                    .navigationTitle("HabitTrax")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

// MARK: - AddHabit_Previews

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
