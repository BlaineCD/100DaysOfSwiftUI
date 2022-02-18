//
//  CachedUser+CoreDataProperties.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
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

    public var wrappedID: UUID {
        id ?? UUID()
    }

    public var wrappedName: String {
        name ?? "Unknown Name"
    }

    public var wrappedEmail: String {
        email ?? "No Email"
    }

    public var wrappedAddress: String {
        address ?? "Unkonwn Address"
    }

    public var wrappedRegistered: Date {
        registered ?? Date()
    }

    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }

    public var wrappedAbout: String {
        about ?? ""
    }

    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []

        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

extension CachedUser : Identifiable {

}
