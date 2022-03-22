//
//  Friend+CoreDataProperties.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/21/22.
//
//

import Foundation
import CoreData
import MapKit

extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

    public var wrappedName: String {
        name ?? "Melquiades"
    }

    public var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Friend : Identifiable {

}
