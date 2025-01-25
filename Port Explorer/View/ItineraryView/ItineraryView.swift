//
//  ItineraryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct ItineraryView: View {
    
    @StateObject private var viewModel: ItineraryViewModel
    
    init(viewModel: ItineraryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack() {
            VStack {
                
                //MARK: - ITINERARY LIST
                if let itinerary = viewModel.itinerary {
                    if !viewModel.isGridViewActive {
                        List {
                            BannerImageView(image: itinerary.image)
                            
                            ForEach(itinerary.portsOfCall) { port in
                                NavigationLink(destination: PortDetailView(port: port)) {
                                    PortListItemView(port: port)
                                }
                            }//:LOOP
                        }//:LIST
                        .listStyle(.plain)
                        
                        //MARK: - GRID STYLE LIST
                    } else {
                        ScrollView {
                            BannerImageView(image: itinerary.image)
                            LazyVGrid(columns: viewModel.gridLayout, alignment: .center) {
                                ForEach(itinerary.portsOfCall) { port in
                                    NavigationLink(destination: PortDetailView(port: port)) {
                                        PortGridItemView(port: port)
                                    }
                                }//:LOOP
                            }//:LAZYVGRID
                            .padding(.horizontal)
                        }//:SCROLLVIEW
                    }//:IF ITINERARY CONDITION
                } else {
                    //EMPTY STATE
                    EmptyStateView(icon: "map", text: "Select an itinerary from the side bar")
                }//:CONDITION
            }//:VSTACK
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.itinerary?.name ?? "Selected Itinerary")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 2) {
                        // LIST
                        Button(action: {
                            viewModel.toggleGridView(isActive: false)
                            HapticsManager.shared.triggerMediumImpact()
                        }) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(viewModel.isGridViewActive ? .primary : .accentColor)
                        }
                        
                        // GRID
                        Button(action: {
                            viewModel.toggleGridView(isActive: true)
                            HapticsManager.shared.triggerMediumImpact()
                        }) {
                            Image(systemName: viewModel.toolbarIcon)
                                .font(.title2)
                                .foregroundColor(viewModel.isGridViewActive ? .accentColor : .primary)
                        }
                    }//:HSTACK
                    .padding(.bottom)
                } //:BUTTONS
            } //:TOOLBAR
        }//:NAVIGATION
    }//:BODY
    
}


#Preview {
    
    let sampleItinerary = SampleItineraryData.sampleItineraries.first

    
    let sampleViewModel = ItineraryViewModel(
        itinerary: sampleItinerary,
        horizontalSizeClass: .compact
    )

    
    ItineraryView(viewModel: sampleViewModel)
}
