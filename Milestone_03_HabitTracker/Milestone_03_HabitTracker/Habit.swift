//
//  Habit.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import Foundation

struct Habit: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    let streak: Int
}
