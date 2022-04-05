//
//  FileManager-DocumentsDirectory.swift
//  Milestone_06_RollTheDice
//
//  Created by Blaine Dannheisser on 4/5/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
