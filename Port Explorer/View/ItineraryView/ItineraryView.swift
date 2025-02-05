//
//  ItineraryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct ItineraryView: View {
    
    @State private var isGridViewActive: Bool = false
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Int = 1
    @State private var toolbarIcon: String = "square.grid.2x2"
    
    let itinerary: Itinerary?
    let horizontalSizeClass: UserInterfaceSizeClass?
    
    init(itinerary: Itinerary?, horizontalSizeClass: UserInterfaceSizeClass?) {
        self.itinerary = itinerary
        self.horizontalSizeClass = horizontalSizeClass
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let itinerary = itinerary {
                        
                        BannerImageView(image: itinerary.image)
                        
                //MARK: - ITINERARY HEADER
                        
                        HStack(alignment: .center) {
                            Text(itinerary.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                            
                            Spacer()
                            Group {
                                // LIST VIEW
                                Button(action: {
                                    isGridViewActive = false
                                    HapticsManager.shared.triggerMediumImpact()
                                }) {
                                    Image(systemName: "square.fill.text.grid.1x2")
                                        .font(.title2)
                                        .foregroundColor(isGridViewActive ? .primary : .accentColor)
                                        .frame(width: Constants.helperIconSize)
                                }
                                
                                // GRID VIEW
                                Button(action: {
                                    isGridViewActive = true
                                    gridSwitch()
                                    HapticsManager.shared.triggerMediumImpact()
                                }) {
                                    Image(systemName: toolbarIcon)
                                        .font(.title2)
                                        .foregroundColor(isGridViewActive ? .accentColor : .primary)
                                        .frame(width: Constants.helperIconSize)
                                }
                            }//:GROUP
                            .padding(.bottom)
                        }//:HSTACK
                        .padding(.horizontal, Constants.horizontalPadding)
                        
                    //MARK: - LIST STYLE LIST
                        
                        if !isGridViewActive {
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
                            
                            LazyVGrid(columns: gridLayout, alignment: .center) {
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
            .navigationTitle(itinerary?.name ?? "Select an Itinerary")
            .navigationBarTitleDisplayMode(.inline)
        }//:NAVIGATION
    }//:BODY
    
    
    //MARK: - FUNCTIONS
    
    //Grid Layout Options
    func gridSwitch() {
        withAnimation(.easeIn) {
            if horizontalSizeClass == .compact {
                // Cycle between 1 and 2 columns for regular size class
                let columnCount = (gridLayout.count == 1) ? 2 : 1
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.verticalSpacing), count: columnCount)
                gridColumn = gridLayout.count
            } else {
                // Cycle between 2 and 3 columns for regular size class
                let columnCount = (gridLayout.count == 2) ? 3 : 2
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.verticalSpacing), count: columnCount)
                gridColumn = gridLayout.count
            }
        }
        
        // TOOLBAR IMAGE
        switch gridColumn {
        case 1:
            toolbarIcon = "square.grid.2x2"
        case 2:
            toolbarIcon = "rectangle.grid.1x2"
        case 3:
            toolbarIcon = "rectangle.grid.1x2"
        default:
            toolbarIcon = "square.grid.2x2"
        }
    }
    
}


#Preview {
    
    let sampleItinerary = SampleItineraryData.sampleItineraries.first
    
    NavigationStack {
        ItineraryView(itinerary: sampleItinerary, horizontalSizeClass: .compact)
    }
}
