//
//  LocationsModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import Foundation
import MapKit

struct PortLocation: Codable, Identifiable {
    let id: String
    let name: String
    let image: String
    var latitude: Double
    var longitude: Double
    
    //Computed property
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

