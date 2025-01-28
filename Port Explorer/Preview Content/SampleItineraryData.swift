//
//  SampleItineraryData.swift
//  Africa
//
//  Created by Jessica Parsons on 1/20/25.
//

import Foundation

struct SampleItineraryData {
    static let sampleItineraries: [Itinerary] = [
        Itinerary(
            id: "itinerary-01",
            name: "Mediterranean Marvels",
            headline: "Experience the rich history and vibrant culture of the Mediterranean.",
            image: "https://junipercreative.co/wp-content/uploads/2025/01/mediterranean.jpg",
            portsOfCall: samplePorts
        )
    ]
    
    static let samplePorts: [Port] = [
            Port(
                id: "port-01",
                name: "Barcelona, Spain",
                headline: "Architectural wonders of Gaudi.",
                description: "Barcelona is a vibrant fusion of history, art, and Mediterranean charm. The Gothic Quarter's winding streets whisper tales of its Roman past, while Antoni Gaudí's architectural masterpieces, such as the Sagrada Familia and Park Güell, showcase unparalleled creativity. Visitors can stroll down La Rambla, savor Catalan cuisine at La Boqueria market, and relax on the sunlit shores of Barceloneta Beach, making Barcelona a city that seamlessly blends culture, beauty, and leisure.",
                link: "https://en.wikipedia.org/wiki/Barcelona",
                image: "https://junipercreative.co/wp-content/uploads/2025/01/barcelona.jpg",
                gallery: ["https://junipercreative.co/wp-content/uploads/2025/01/barcelona1.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/barcelona2.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/barcelona3.jpg"],
                facts: [
                    "Home to 9 UNESCO World Heritage Sites.",
                    "La Rambla is one of the most famous streets in the world.",
                    "The Gothic Quarter dates back to Roman times."
                ],
                location: Location(
                    id: "loc-01",
                    name: "Barcelona, Spain",
                    image: "barcelona_map.jpg",
                    latitude: 41.3851,
                    longitude: 2.1734
                )
            ),
            Port(
                id: "port-02",
                name: "Rome, Italy",
                headline: "The Eternal City awaits with ancient wonders.",
                description: "Rome offers iconic landmarks like the Colosseum, Roman Forum, and Vatican City. It's a must-visit destination for history lovers.",
                link: "https://en.wikipedia.org/wiki/Rome",
                image: "https://junipercreative.co/wp-content/uploads/2025/01/rome.jpg",
                gallery: ["https://junipercreative.co/wp-content/uploads/2025/01/rome1.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/rome2.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/rome3.jpg"],
                facts: [
                    "The Colosseum could hold up to 80,000 spectators.",
                    "The Pantheon has the world's largest unreinforced concrete dome.",
                    "The Vatican is the smallest country in the world."
                ],
                location: Location(
                    id: "loc-02",
                    name: "Rome, Italy",
                    image: "rome_map.jpg",
                    latitude: 41.9028,
                    longitude: 12.4964
                )
            ),
            Port(
                id: "port-03",
                name: "Barcelona, Spain",
                headline: "Architectural wonders of Gaudi.",
                description: "Barcelona is a vibrant fusion of history, art, and Mediterranean charm. The Gothic Quarter's winding streets whisper tales of its Roman past, while Antoni Gaudí's architectural masterpieces, such as the Sagrada Familia and Park Güell, showcase unparalleled creativity. Visitors can stroll down La Rambla, savor Catalan cuisine at La Boqueria market, and relax on the sunlit shores of Barceloneta Beach, making Barcelona a city that seamlessly blends culture, beauty, and leisure.",
                link: "https://en.wikipedia.org/wiki/Barcelona",
                image: "https://junipercreative.co/wp-content/uploads/2025/01/barcelona.jpg",
                gallery: ["https://junipercreative.co/wp-content/uploads/2025/01/barcelona1.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/barcelona2.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/barcelona3.jpg"],
                facts: [
                    "Home to 9 UNESCO World Heritage Sites.",
                    "La Rambla is one of the most famous streets in the world.",
                    "The Gothic Quarter dates back to Roman times."
                ],
                location: Location(
                    id: "loc-03",
                    name: "Barcelona, Spain",
                    image: "barcelona_map.jpg",
                    latitude: 41.3851,
                    longitude: 2.1734
                )
            ),
            Port(
                id: "port-04",
                name: "Rome, Italy",
                headline: "The Eternal City awaits with ancient wonders.",
                description: "Rome offers iconic landmarks like the Colosseum, Roman Forum, and Vatican City. It's a must-visit destination for history lovers.",
                link: "https://en.wikipedia.org/wiki/Rome",
                image: "https://junipercreative.co/wp-content/uploads/2025/01/rome.jpg",
                gallery: ["https://junipercreative.co/wp-content/uploads/2025/01/rome1.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/rome2.jpg", "https://junipercreative.co/wp-content/uploads/2025/01/rome3.jpg"],
                facts: [
                    "The Colosseum could hold up to 80,000 spectators.",
                    "The Pantheon has the world's largest unreinforced concrete dome.",
                    "The Vatican is the smallest country in the world."
                ],
                location: Location(
                    id: "loc-04",
                    name: "Rome, Italy",
                    image: "rome_map.jpg",
                    latitude: 41.9028,
                    longitude: 12.4964
                )
            )
        ]

}
