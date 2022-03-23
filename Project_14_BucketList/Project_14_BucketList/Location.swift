//
//  Location.swift
//  Project_14_BucketList
//
//  Created by Blaine Dannheisser on 3/9/22.
//

import CoreLocation
import Foundation

struct Location: Identifiable, Equatable, Codable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double

    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static var example = Location(id: UUID(), name: "Follonico", description: "Tuscan getaway", latitude: 43.13343, longitude: 11.76721)

    // MARK: Internal
 
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

}
