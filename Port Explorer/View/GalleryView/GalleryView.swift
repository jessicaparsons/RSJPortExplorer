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
    @Binding var selectedTab: MainView.Tabs
    
    private var allImages: [String] {
        viewModel.itinerary.flatMap { itinerary in
            // Combine itinerary-level and port-level images
            [itinerary.image] + itinerary.portsOfCall.flatMap { port in
                [port.image] + port.gallery // Include port gallery images
            }
        }
    }
    //!viewModel.itinerary.isEmpty ? viewModel.itinerary : []
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    @State private var selectedPhoto: String = "ocho_rios1"
    @State private var previousRoundedColumn: Int = 3
    
    func gridSwitch() {
        withAnimation(.easeIn) {
            let roundedColumns = Int(gridColumn.rounded())
            gridLayout = Array(repeating: .init(.flexible()), count: Int(roundedColumns))
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 30) {
                    //MARK: - IMAGE
                    if let url = URL(string: selectedPhoto) {
                        KFImage(url)
                            .placeholder {
                                Image("ocho_rios1")
                                    .resizable()
                                    .aspectRatio(4/3, contentMode: .fit)
                                    .cornerRadius(Constants.cornerRadius)
                            }
                            .onFailure { error in
                                print("Failed to load itinerary image: \(error.localizedDescription)")
                            }
                            .cacheOriginalImage()
                            .resizable()
                            .aspectRatio(4/3, contentMode: .fit)
                            .cornerRadius(Constants.cornerRadius)
                            .accessibilityLabel("Featured gallery image")
                    }
                    
                    //MARK: - SLIDER
                    
                    Slider(value: $gridColumn, in: 2...4)
                        .padding(.horizontal)
                        .onChange(of: gridColumn) {
                            let currentRoundedColumn = Int(gridColumn.rounded())
                            if currentRoundedColumn != previousRoundedColumn {
                                HapticsManager.shared.triggerMediumImpact()
                                previousRoundedColumn = currentRoundedColumn
                            }
                            
                            gridSwitch()
                        }
                    
                    
                    //MARK: - GRID
                    if allImages.isEmpty {
                        ProgressView("Loading Images...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(allImages, id: \.self) { image in
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
                                            HapticsManager.shared.triggerMediumImpact()
                                        }//:IMAGE
                                }//:CONDITION
                            }//:LOOP
                        }//:GRID
                        .onAppear(perform: {
                            gridSwitch()
                        })
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
    }
}

#Preview {
    @Previewable @State var selectedTab = MainView.Tabs.itinerary

    GalleryView(selectedTab: $selectedTab)
}
