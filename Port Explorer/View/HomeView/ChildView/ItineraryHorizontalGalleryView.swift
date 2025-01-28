//
//  ItineraryHorizontalGalleryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/27/25.
//

import SwiftUI

struct ItineraryHorizontalGalleryView: View {
    
    let title: String
    let image: String
    let itineraries: [Itinerary]
    let horizontalSizeClass: UserInterfaceSizeClass?
    let numberOfItineraries: Int
    let isPrefix: Bool
    
    //Custom logic to display the first or last few items of my sample itinerary array. In production, this would be filtered specifically based on topic, etc.
    private var displayedItineraries: [Itinerary] {
        isPrefix ? Array(itineraries.prefix(numberOfItineraries)) : Array(itineraries.suffix(numberOfItineraries))
    }

    var body: some View {
        Group {
            HeadingView(headingImage: image, headingText: title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: Constants.gridSpacing) {
                    ForEach(displayedItineraries) { itinerary in
                        NavigationLink(destination:
                                        ItineraryView(
                                            viewModel: ItineraryViewModel(
                                                itinerary: itinerary,
                                                horizontalSizeClass: horizontalSizeClass)
                                        )
                        ) {
                            ItineraryListItemView(itinerary: itinerary)
                                .frame(width: horizontalSizeClass == .compact ? Constants.galleryHeight : (Constants.galleryHeight * 1.5))
                        }
                    }//:LOOP
                }//:LAZYHSTACK
            }//:SCROLLVIEW
        }//:GROUP
    }
}

#Preview {
    HomeView(horizontalSizeClass: .regular)
}
