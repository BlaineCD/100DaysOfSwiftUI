//
//  DataController.swift
//  Project_11_Bookworm
//
//  Created by Blaine Dannheisser on 2/2/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { NSEntityDescription, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription )")
            }
        }
    }
}
