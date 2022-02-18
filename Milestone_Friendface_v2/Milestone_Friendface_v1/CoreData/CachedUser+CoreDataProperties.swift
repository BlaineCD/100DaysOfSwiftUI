//
//  CachedUser+CoreDataProperties.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/18/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var registered: Date?
    @NSManaged public var company: String?
    @NSManaged public var about: String?
    @NSManaged public var friends: NSSet?

    var wrappedID: UUID {
        id ?? UUID()
    }

    var wrappedName: String {
        name ?? "Unknown Name"
    }

    var wrappedEmail: String {
        email ?? "No Email"
    }

    var wrappedAddress: String {
        address ?? "Unkonwn Address"
    }

     var wrappedRegistered: Date {
        registered ?? Date()
    }

    var wrappedCompany: String {
        company ?? "Unknown Company"
    }

    var wrappedAbout: String {
        about ?? ""
    }

    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedFriendName < $1.wrappedFriendName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
