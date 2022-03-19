//
//  Milestone_05_NameAndFaceApp.swift
//  Milestone_05_NameAndFace
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import SwiftUI

@main
struct Milestone_05_NameAndFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // .managedObjectContext = live versions of data
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
