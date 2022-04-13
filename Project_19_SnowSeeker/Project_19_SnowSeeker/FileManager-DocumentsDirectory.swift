//
//  FileManager-DocumentsDirectory.swift
//  Project_19_SnowSeeker
//
//  Created by Blaine Dannheisser on 4/11/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
