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
        VStack(alignment: .leading, spacing: 8) {
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
                    .aspectRatio(4/3, contentMode: .fit)
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
    @Previewable @State var selectedTab = MainView.Tabs.itinerary
    
    ItineraryView(selectedTab: $selectedTab, itinerary: SampleItineraryData.sampleItineraries.first)
    
}
