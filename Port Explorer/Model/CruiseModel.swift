//
//  CruiseModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import Foundation
import MapKit

struct Cruise: Codable {
    let cruiseLine: CruiseLine
}

struct CruiseLine: Codable, Identifiable {
    let id: String
    let name: String
    let itineraries: [Itinerary]
}

struct Itinerary: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let headline: String
    let image: String
    let portsOfCall: [Port]
}

struct Port: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let headline: String
    let description: String
    let link: String
    let image: String
    let gallery: [String]
    let facts: [String]
    let location: Location
}

struct Location: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let latitude: Double
    let longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}



