//
//  Project_12_CoreDataProjectApp.swift
//  Project_12_CoreDataProject
//
//  Created by Blaine Dannheisser on 2/15/22.
//

import SwiftUI

@main
struct Project_12_CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
            // .managedObjectContext = live versions of data
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
