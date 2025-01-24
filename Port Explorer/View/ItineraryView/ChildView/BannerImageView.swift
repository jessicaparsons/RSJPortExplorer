//
//  BannerImageView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/23/25.
//

import SwiftUI
import Kingfisher



struct BannerImageView: View {
    
    let image: String?
    
    var body: some View {
        if let validURL = validateURL(from: image) {
            KFImage(validURL)
                .placeholder {
                    PlaceholderImageView()
                }
                .onFailure { error in
                    print("Failed to load itinerary image: \(error.localizedDescription)")
                }
                .cacheOriginalImage()
                .resizable()
                .frame(height: Constants.photoBannerHeight)
                .listRowInsets(EdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0))
                .padding(.bottom)
        } else {
            FailureImageView(width: nil, height: Constants.photoBannerHeight)
        }
    }
    
    //MARK: - FUNCTIONS
    
    private func validateURL(from urlString: String?) -> URL? {
        guard let urlString = urlString?.trimmingCharacters(in: .whitespacesAndNewlines),
              let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url)
        else {
            return nil
        }
        return url
    }
}



#Preview {
    
    if let itinerary = SampleItineraryData.sampleItineraries.first {
        BannerImageView(image: itinerary.image)
    }
    
    if let port = SampleItineraryData.sampleItineraries.first?.portsOfCall.first {
        BannerImageView(image: port.image)
    }
}
