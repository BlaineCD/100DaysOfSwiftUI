//
//  Prospect.swift
//  Project_16_HotProspects
//
//  Created by Blaine Dannheisser on 3/25/22.
//

import SwiftUI

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    //    var saveKey = "SavedData"

    // Challenge 2: Use JSON and documents directory for saving and loading user data. 
    var savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")

    //    init() {
    //        if let data = UserDefaults.standard.data(forKey: saveKey) {
    //            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
    //                people = decoded
    //                return
    //            }
    //        }
    //        people = []
    //    }

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }

    //    private func save() {
    //        if let encoded = try? JSONEncoder().encode(people) {
    //            UserDefaults.standard.set(encoded, forKey: saveKey)
    //            print("Saved")
    //        }
    //    }

    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to Save Data")
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
