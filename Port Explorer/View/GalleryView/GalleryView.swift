//
//  GalleryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    
    @StateObject private var galleryViewModel: GalleryViewModel
    @StateObject var viewModel = CruiseViewModel()
    
    @State private var selectedItineraryId: String? = nil
    @State private var selectedPhoto: ImageItem? = nil
    @State private var showFullScreenImage: Bool = false
    
    let horizontalSizeClass: UserInterfaceSizeClass?
    
    var filteredImages: [ImageItem] {
        //filter by ID
        if let itineraryId = selectedItineraryId {
            return viewModel.images(forItineraryId: itineraryId).map { url in
                ImageItem(id: url, url: url) }
        } else {
        //Return all images
            return viewModel.itinerary.flatMap { itinerary in
                [itinerary.image] + itinerary.portsOfCall.flatMap { [$0.image] + $0.gallery }
            }.map { url in
                ImageItem(id: url, url: url) }
        }
    }
    
    init(horizontalSizeClass: UserInterfaceSizeClass?) {
        _galleryViewModel = StateObject(wrappedValue: GalleryViewModel(horizontalSizeClass: horizontalSizeClass))
        self.horizontalSizeClass = horizontalSizeClass
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: Constants.verticalSpacing) {
                    HStack(alignment: .center) {
                        
                        //MARK: - PICKER
                        
                        Picker("Select Itinerary", selection: $selectedItineraryId) {
                            Text(selectedItineraryId == nil ? "Filter by itinerary" : "All Images")
                                .tag(nil as String?)
                                .font(.caption)
                            ForEach(viewModel.itinerary, id: \.id) { itinerary in
                                Text(itinerary.name)
                                    .tag(itinerary.id as String?)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedItineraryId) {
                            HapticsManager.shared.triggerMediumImpact()
                        }
                        
                        Spacer()
                        
                        //MARK: - GALLERY DISPLAY CHANGE BUTTON
                        Button(action: {
                            galleryViewModel.toggleGridView(isActive: true)
                            HapticsManager.shared.triggerMediumImpact()
                        }) {
                            Image(systemName: galleryViewModel.toolbarIcon)
                                .font(.title2)
                                .foregroundColor(.accentColor)
                        }
                    }//:HSTACK
                    
                    
                    //MARK: - GRID
                    
                    if filteredImages.isEmpty {
                        ProgressView("Loading Images...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        LazyVGrid(columns: galleryViewModel.gridLayout, alignment: .center, spacing: Constants.photoGridSpacing) {
                            ForEach(filteredImages) { image in
                                if let url = URL(string: image.url) {
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
                                        .onTapGesture {
                                            selectedPhoto = image
                                            HapticsManager.shared.triggerMediumImpact()
                                        }//:IMAGE
                                }//:CONDITION
                            }//:LOOP
                        }//:GRID
                    }//:CONDITION
                }//:VSTACK
                .padding(.horizontal, Constants.horizontalPadding)
            }//:SCROLL
            .navigationTitle("Photo Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }//:NAVIGATION
        .task {
            await viewModel.fetchCruiseData()
        }
        .fullScreenCover(item: $selectedPhoto) { image in
            FullScreenImageView(selectedPhoto: image.url)
        }//:FULLSCREEN COVER
    }
    
}



//MARK: - PREVIEW

#Preview {
    GalleryView(horizontalSizeClass: .compact)
}
