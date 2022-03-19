//
//  DataController.swift
//  Milestone_05_NameAndFace
//
//  Created by Blaine Dannheisser on 3/17/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Person")

    // MARK: Lifecycle

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
