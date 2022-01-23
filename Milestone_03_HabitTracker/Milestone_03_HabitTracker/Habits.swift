//
//  Habits.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import Foundation

class Habits: ObservableObject {

    @Published var items = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }

    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            if let savedHabits = try? JSONDecoder().decode([Habit].self, from: habits) {
                items = savedHabits
                return
            }
        }
        items = []
    }
}
