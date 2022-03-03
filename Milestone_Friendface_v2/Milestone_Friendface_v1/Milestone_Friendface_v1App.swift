//
//  Milestone_Friendface_v1App.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import SwiftUI

@main
struct Milestone_Friendface_v1App: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
