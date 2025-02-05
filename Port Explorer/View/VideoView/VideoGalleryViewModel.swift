//
//  VideoGalleryViewModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 2/4/25.
//

import Foundation

class VideoGalleryViewModel: ObservableObject {
    
    @Published var video: [PixabayVideo] = []
    // Videos grouped by search term
    @Published var videosBySearchTerm: [String: [PixabayVideo]] = [:]
   
    let videosBaseURL = Constants.videosBaseURL
    
    func fetchVideoData(for searchTerm: String) async {
        guard let videosAPIKey = SecretsManager.getAPIKey() else {
            print("API key not found")
            return
        }
        
        guard let url = URL(string: "\(videosBaseURL)?key=\(videosAPIKey)&safesearch=true&per_page=5&category=travel&q=\(searchTerm)") else {
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: 10)
    
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("invalid response")
                return
            }
            
            let decodedData = try JSONDecoder().decode(PixabayVideoResponse.self, from: data)
            
            //update the UI on the main thread
            
            await MainActor.run {
                self.video = decodedData.hits
                self.videosBySearchTerm[searchTerm] = decodedData.hits
            }
            
            
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
}
