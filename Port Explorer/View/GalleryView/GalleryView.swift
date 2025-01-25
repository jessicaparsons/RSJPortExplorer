//
//  GalleryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @StateObject private var galleryViewModel: GalleryViewModel
    @StateObject var viewModel = CruiseViewModel()
    
    @State private var selectedItineraryId: String? = nil
    @State private var selectedPhoto: String? = nil
    @State private var showFullScreenImage: Bool = false
    
    
    init(horizontalSizeClass: UserInterfaceSizeClass?) {
        self._galleryViewModel = StateObject(wrappedValue: GalleryViewModel(horizontalSizeClass: horizontalSizeClass))
    }
    
    var filteredImages: [String] {
        if let itineraryId = selectedItineraryId {
            return viewModel.images(forItineraryId: itineraryId)
        } else {
            return viewModel.itinerary.flatMap { itinerary in
                [itinerary.image] + itinerary.portsOfCall.flatMap { [$0.image] + $0.gallery }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 30) {
                    
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
                        LazyVGrid(columns: galleryViewModel.gridLayout, alignment: .center, spacing: 10) {
                            ForEach(filteredImages, id: \.self) { image in
                                if let url = URL(string: image) {
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
                                        .onTapGesture {
                                            selectedPhoto = image
                                            DispatchQueue.main.async {
                                                showFullScreenImage = true
                                            }
                                            
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
            selectedPhoto = filteredImages.first
        }
        .fullScreenCover(isPresented: $showFullScreenImage) {
            if let photo = selectedPhoto {
                FullScreenImageView(imageURL: photo)
            } else {
                VStack(spacing: Constants.verticalSpacing) {
                    Text("No image available")
                    Button("Close") {
                        showFullScreenImage = false
                    }
                }
                
            }
        }
    }
    
}

//MARK: - PREVIEW

#Preview {
    NavigationStack{
        GalleryView(horizontalSizeClass: .compact)
    }
}
