//
//  ItineraryTitleView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/27/25.
//

import SwiftUI

struct ItineraryTitleView: View {
    
    @ObservedObject var viewModel: ItineraryViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Text(viewModel.itinerary?.name ?? "Selected Itinerary")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Spacer()
            Group {
                // LIST VIEW
                Button(action: {
                    viewModel.toggleGridView(isActive: false)
                    HapticsManager.shared.triggerMediumImpact()
                }) {
                    Image(systemName: "square.fill.text.grid.1x2")
                        .font(.title2)
                        .foregroundColor(viewModel.isGridViewActive ? .primary : .accentColor)
                        .frame(width: Constants.helperIconSize)
                }
                
                // GRID VIEW
                Button(action: {
                    viewModel.toggleGridView(isActive: true)
                    HapticsManager.shared.triggerMediumImpact()
                }) {
                    Image(systemName: viewModel.toolbarIcon)
                        .font(.title2)
                        .foregroundColor(viewModel.isGridViewActive ? .accentColor : .primary)
                        .frame(width: Constants.helperIconSize)
                }
            }//:GROUP
            .padding(.bottom)
        }//:HSTACK
        .listRowSeparator(.hidden)
        .padding(.horizontal, Constants.horizontalPadding)
    }
}

#Preview {
    let sampleItinerary = SampleItineraryData.sampleItineraries.first
    let sampleViewModel = ItineraryViewModel(
        itinerary: sampleItinerary,
        horizontalSizeClass: .compact
    )
    NavigationStack {
        ItineraryTitleView(viewModel: sampleViewModel)
    }
}
