//
//  Project_11_BookwormApp.swift
//  Project_11_Bookworm
//
//  Created by Blaine Dannheisser on 1/29/22.
//

import SwiftUI

@main
struct Project_11_BookwormApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
            // .managedObjectContext = live versions of data
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
