//
//  DataController.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/18/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friendface")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Failed To Load: \(error.localizedDescription)")
            }
        }
    }
}
