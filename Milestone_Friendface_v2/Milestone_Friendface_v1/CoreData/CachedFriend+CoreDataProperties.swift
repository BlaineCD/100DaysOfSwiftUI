//
//  CachedFriend+CoreDataProperties.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/18/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    public var wrappedFriendName: String {
        name ?? "Unknown Name"
    }


}

extension CachedFriend : Identifiable {

}
