//
//  AnimalListItemView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/17/25.
//

import SwiftUI
import Kingfisher

struct PortListItemView: View {
    
    let port: Port
    
    var body: some View {
        HStack(alignment: .center, spacing: Constants.gridSpacing) {
            KFImage(URL(string: port.image))
                .placeholder {
                    PlaceholderImageView()
                }
                .onFailure { error in
                    print("Failed to load itinerary image: \(error.localizedDescription)")
                }
                .resizable()
                .cacheOriginalImage()
                .scaledToFill()
                .frame(width: Constants.listIconFrame, height: Constants.listIconFrame)
                .clipShape(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                )
                .accessibilityLabel("Featured image for \(port.name)")
            VStack(alignment: .leading, spacing: Constants.photoGridSpacing) {
                Text(port.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.leading)
                
                Text(port.headline)
                    .font(.footnote)
                    .tint(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
            }//:VSTACK
        }//:HSTACK
    }
}

#Preview {
    
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        PortListItemView(port: port)
    } else {
       Text("error")
    }
}
