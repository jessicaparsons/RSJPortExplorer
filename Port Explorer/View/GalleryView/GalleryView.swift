//
//  GalleryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    
    @StateObject var viewModel = CruiseViewModel()
    
    @State private var selectedItineraryId: String? = nil
    @State private var selectedPhoto: ImageItem? = nil
    @State private var showFullScreenImage: Bool = false
    @State private var isGridViewActive: Bool = false
    @State private var gridLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: Constants.photoGridSpacing), count: 2)
    @State private var gridColumn: Int = 3
    @State private var toolbarIcon: String = "square.grid.2x2"
    
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
                            gridSwitch()
                            HapticsManager.shared.triggerMediumImpact()
                        }) {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(.accentColor)
                        }
                    }//:HSTACK
                    
                    
                    //MARK: - GRID
                    
                    if filteredImages.isEmpty {
                        ProgressView("Loading Images...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: Constants.photoGridSpacing) {
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
    
    //MARK: - FUNCTIONS
    
    //Grid Layout Options
    func gridSwitch() {
        withAnimation(.easeIn) {
            
            if horizontalSizeClass == .compact {
                // Cycle between 1, 2, 3 columns for compact size class
                let columnCount = (gridLayout.count % 3) + 1
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.photoGridSpacing), count: columnCount)
                gridColumn = gridLayout.count
            } else {
                // Cycle between 2, 3, 4 columns for regular size class
                let columnCount = gridLayout.count % 3 + 2 // Increment and reset (2 -> 3 -> 4 -> 2)
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.photoGridSpacing), count: columnCount)
                gridColumn = gridLayout.count
            }
        }
        
        
        // TOOLBAR IMAGE
        switch gridColumn {
        case 1:
            toolbarIcon = "square.grid.2x2" // 1 column
        case 2:
            toolbarIcon = "square.grid.3x2" // 2 columns
        case 3:
            toolbarIcon = "rectangle.grid.1x2" // 3 columns
        default:
            toolbarIcon = "square.grid.2x2"
        }
    }
    
}



//MARK: - PREVIEW

#Preview {
    GalleryView(horizontalSizeClass: .compact)
}
