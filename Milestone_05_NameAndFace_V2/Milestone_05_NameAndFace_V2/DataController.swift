//
//  DataController.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friend")

    // MARK: Lifecycle

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
