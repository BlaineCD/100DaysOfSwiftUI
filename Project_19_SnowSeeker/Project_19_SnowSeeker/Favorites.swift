//
//  Favorites.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/11/22.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private var saveKey = "Favorites"

    var savePath = FileManager.documentsDirectory.appendingPathComponent("SaveData")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
