//
//  CruiseViewModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import Foundation


@MainActor
class CruiseViewModel: ObservableObject {
    @Published var videosBySearchTerm: [String: [PixabayVideo]] = [:] // Videos grouped by search term
    @Published var itinerary: [Itinerary] = []
    @Published var video: [PixabayVideo] = []

    let cruiseURL = "https://mocki.io/v1/420519f1-71fe-4583-98ff-f7c9a2a0bbf4"
    let videosBaseURL = "https://pixabay.com/api/videos/"
    
    func fetchCruiseData() async {
            await fetchData(from: cruiseURL, decodeTo: Cruise.self) { [weak self] decodedData in
                self?.itinerary = decodedData.cruiseLine.itineraries
            }
    }
    
    func fetchVideoData(for searchTerm: String) async {
        if let videosAPIKey = SecretsManager.getAPIKey() {
            await fetchData(from: "\(videosBaseURL)?key=\(videosAPIKey)&safesearch=true&per_page=10&category=travel&q=\(searchTerm)", decodeTo: PixabayVideoResponse.self) { [weak self] decodedData in
                self?.video = decodedData.hits
                self?.videosBySearchTerm[searchTerm] = decodedData.hits
            }
        } else {
            print("API key not found")
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
