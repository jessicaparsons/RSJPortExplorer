//
//  CruiseViewModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import Foundation


@MainActor
class CruiseViewModel: ObservableObject {
    
    @Published var itinerary: [Itinerary] = []
    
    var allPorts: [Port] {
        itinerary.flatMap { $0.portsOfCall }
    }

    let cruiseURL = Constants.cruiseDataURL
    
    func fetchCruiseData() async {
            await fetchData(from: cruiseURL, decodeTo: Cruise.self) { [weak self] decodedData in
                self?.itinerary = decodedData.cruiseLine.itineraries
            }
    }

    private func fetchData<T: Decodable>(from urlString: String, decodeTo type: T.Type, completion: @escaping (T) -> Void) async {
            do {
                guard let url = URL(string: urlString) else {
                    print("Invalid URL")
                    return
                }
                let (data, response) = try await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("Invalid response")
                    return
                }
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
    }
    
    // Computed property to group images by itineraryId
    func images(forItineraryId id: String) -> [String] {
        guard let itinerary = itinerary.first(where: { $0.id == id }) else {
            return []
        }
        
        // Collect all images for the specific itinerary
        return [itinerary.image] + itinerary.portsOfCall.flatMap { [$0.image] + $0.gallery }
    }
    
}
