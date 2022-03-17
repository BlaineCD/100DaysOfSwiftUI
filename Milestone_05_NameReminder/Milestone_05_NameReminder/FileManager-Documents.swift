//
//  FileManager-Documents.swift
//  Milestone_05_NameReminder
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
