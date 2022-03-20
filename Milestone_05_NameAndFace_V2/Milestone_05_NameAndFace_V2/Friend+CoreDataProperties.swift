//
//  Friend+CoreDataProperties.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var id: UUID?

    public var wrappedName: String {
        name ?? "Melquiades"
    }
}

extension Friend : Identifiable {

}
