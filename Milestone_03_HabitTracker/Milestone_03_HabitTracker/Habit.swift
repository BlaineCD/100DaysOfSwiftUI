//
//  Habit.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import Foundation
import SwiftUI

struct Habit: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var notes: [String]
    var count: Int
    var dates = [Date]()
    var color: String
}
