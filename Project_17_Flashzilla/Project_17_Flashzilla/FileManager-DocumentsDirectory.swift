//
//  FileManager-DocumentsDirectory.swift
//  Project_17_Flashzilla
//
//  Created by Blaine Dannheisser on 4/3/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
