//
//  ItineraryListItemView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/20/25.
//

import SwiftUI
import Kingfisher

struct ItineraryListItemView: View {
    
    let itinerary: Itinerary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let url = URL(string: itinerary.image) {
                KFImage(url)
                    .placeholder {
                        PlaceholderImageView()
                    }
                    .onFailure { error in
                        print("Failed to load itinerary image: \(error.localizedDescription)")
                    }
                    .resizable()
                    .cacheOriginalImage()
                    .aspectRatio(4/3, contentMode: .fit)
                    .cornerRadius(Constants.cornerRadius)
                    .accessibilityLabel("Image of \(itinerary.name)")
                
                Text(itinerary.name)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                
                Text(itinerary.headline)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .padding(.trailing, 8)
                Spacer()
            }//:CONDITION
        }//:VSTACK
        .frame(maxHeight: .infinity)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    if let itinerary = SampleItineraryData.sampleItineraries.first {
        ItineraryListItemView(itinerary: itinerary)
    } else {
        Text("error")
    }
}

#Preview("Home Screen") {
    @Previewable @State var selectedTab = MainView.Tabs.itinerary
    
    HomeView(selectedTab: $selectedTab)
}
