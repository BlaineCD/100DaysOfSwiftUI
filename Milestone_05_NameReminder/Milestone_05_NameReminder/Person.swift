//
//  Person.swift
//  Milestone_05_NameReminder
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import Foundation
import SwiftUI

struct Person: Codable, Identifiable {
    var id: UUID
    var name: String
}

class People: ObservableObject {
    @Published var people = [Person]()
}
