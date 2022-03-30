//
//  FileManager-DocumentsDirectory.swift
//  Project_16_HotProspects
//
//  Created by Blaine Dannheisser on 3/29/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
