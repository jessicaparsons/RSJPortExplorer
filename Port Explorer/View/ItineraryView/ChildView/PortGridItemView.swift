//
//  PortGridItemView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/20/25.
//

import SwiftUI
import Kingfisher

struct PortGridItemView: View {
    
    let port: Port
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.photoGridSpacing) {
            if let url = URL(string: port.image) {
                KFImage(url)
                    .placeholder {
                        PlaceholderImageView()
                    }
                    .onFailure { error in
                        print("Failed to load itinerary image: \(error.localizedDescription)")
                    }
                    .cacheOriginalImage()
                    .resizable()
                    .aspectRatio(Constants.aspectRatio, contentMode: .fit)
                    .cornerRadius(Constants.cornerRadius)
                    .accessibilityLabel("Featured image of \(port.name)")
                Text(port.name)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                    .foregroundColor(.accentColor)
                
                Text(port.headline)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
                Spacer()
            }//:CONDITION
        }//:VSTACK
        .frame(maxHeight: .infinity)        
    }
}

#Preview {
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        PortGridItemView(port: port)
    } else {
       Text("error")
    }
}

#Preview("Itinerary View") {
    
    let sampleItinerary = SampleItineraryData.sampleItineraries.first
    
    ItineraryView(itinerary: sampleItinerary, horizontalSizeClass: .compact)
    
}
