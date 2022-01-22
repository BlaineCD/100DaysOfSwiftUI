//
//  HabitDetail.swift
//  Milestone_03_HabitTracker
//
//  Created by Blaine Dannheisser on 1/21/22.
//

import SwiftUI

struct HabitDetailView: View {

    let habit: Habit

    var body: some View {
        List {
            Text("Testing")
        }
        .navigationTitle(habit.name)
    }
}

struct HabitDetail_Previews: PreviewProvider {

    static var previews: some View {
        HabitDetailView(habit: Habit(name: "Eat Healhty", description: "Twice A Week"))
    }
}
