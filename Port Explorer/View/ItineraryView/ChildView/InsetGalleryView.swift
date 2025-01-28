//
//  InsetGalleryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import SwiftUI
import Kingfisher

struct InsetGalleryView: View {
    
    @State private var selectedPhoto: ImageItem? = nil
    let port: Port
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: Constants.gridSpacing) {
                ForEach(port.gallery, id: \.self) { image in
                    KFImage(URL(string: image))
                        .placeholder {
                            PlaceholderImageView()
                        }
                        .onFailure { error in
                            print("Failed to load itinerary image: \(error.localizedDescription)")
                        }
                        .cacheOriginalImage()
                        .resizable()
                        .scaledToFit()
                        .frame(height: Constants.galleryHeight)
                        .cornerRadius(Constants.cornerRadius)
                        .onTapGesture {
                            selectedPhoto = ImageItem(id: image, url: image)
                            HapticsManager.shared.triggerMediumImpact()
                        }//:IMAGE
                        .accessibilityLabel("Gallery images of \(port.name)")
                }//:LOOP
            }//:HSTACK
        }//:SCROLL
        .fullScreenCover(item: $selectedPhoto) { image in
            FullScreenImageView(selectedPhoto: image.url)
        }//:FULLSCREEN COVER
    }
}

#Preview {
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        InsetGalleryView(port: port)
    } else {
        Text("error")
    }
}
