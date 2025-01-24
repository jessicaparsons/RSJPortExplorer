//
//  AnimalModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/17/25.
//

import Foundation

struct Animal: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let headline: String
    let description: String
    let link: String
    let image: String
    let gallery: [String]
    let fact: [String]
}
