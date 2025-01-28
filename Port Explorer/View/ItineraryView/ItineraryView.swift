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
        NavigationStack {
            ScrollView {
                VStack {
                    if let itinerary = viewModel.itinerary {
                        
                        BannerImageView(image: itinerary.image)
                        
                        ItineraryTitleView(viewModel: viewModel)
                        
                    //MARK: - LIST STYLE LIST
                        
                        if !viewModel.isGridViewActive {
                            LazyVStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                                ForEach(itinerary.portsOfCall) { port in
                                    NavigationLink(destination: PortDetailView(port: port)) {
                                        PortListItemView(port: port)
                                    }
                                }//:LOOP
                            }//:LAZYVSTACK
                            .padding(.horizontal)
                            
                    //MARK: - GRID STYLE LIST
                            
                        } else {
                            
                            LazyVGrid(columns: viewModel.gridLayout, alignment: .center) {
                                ForEach(itinerary.portsOfCall) { port in
                                    NavigationLink(destination: PortDetailView(port: port)) {
                                        PortGridItemView(port: port)
                                    }
                                }//:LOOP
                            }//:LAZYVGRID
                            .padding(.horizontal)
                            
                        }//:IF ITINERARY CONDITION
                    } else {
                        //EMPTY STATE
                        EmptyStateView(icon: "map", text: "Select an itinerary from the side bar")
                    }//:CONDITION
                }//:VSTACK
            }//:SCROLLVIEW
            .navigationTitle(viewModel.itinerary?.name ?? "Select an Itinerary")
            .navigationBarTitleDisplayMode(.inline)
        }//:NAVIGATION
    }//:BODY
    
}


#Preview {
    
    let sampleItinerary = SampleItineraryData.sampleItineraries.first
    
    
    let sampleViewModel = ItineraryViewModel(
        itinerary: sampleItinerary,
        horizontalSizeClass: .compact
    )
    
    NavigationStack {
        ItineraryView(viewModel: sampleViewModel)
    }
}
