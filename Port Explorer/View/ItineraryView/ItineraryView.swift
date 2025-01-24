//
//  ItineraryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct ItineraryView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var selectedTab: MainView.Tabs
    
    let itinerary: Itinerary?
    
    @State private var isGridViewActive: Bool = false
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Int = 1
    @State private var toolbarIcon: String = "square.grid.2x2"
    
    
    var body: some View {
        NavigationStack() {
            VStack {
                
                //MARK: - ITINERARY LIST
                if let itinerary {
                    if !isGridViewActive {
                        List {
                            BannerImageView(image: itinerary.image)
                            
                            ForEach(itinerary.portsOfCall) { port in
                                NavigationLink(destination: PortDetailView(selectedTab: $selectedTab, port: port)) {
                                    PortListItemView(port: port)
                                }
                            }//:LOOP
                        }//:LIST
                        .listStyle(.plain)
                        
                        //MARK: - GRID STYLE LIST
                    } else {
                        ScrollView {
                            BannerImageView(image: itinerary.image)
                            LazyVGrid(columns: gridLayout, alignment: .center) {
                                ForEach(itinerary.portsOfCall) { port in
                                    NavigationLink(destination: PortDetailView(selectedTab: $selectedTab, port: port)) {
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
                    Text(itinerary?.name ?? "Selected Itinerary")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 2) {
                        // LIST
                        Button(action: {
                            isGridViewActive = false
                            HapticsManager.shared.triggerMediumImpact()
                        }) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
                        }
                        
                        // GRID
                        Button(action: {
                            isGridViewActive = true
                            HapticsManager.shared.triggerMediumImpact()
                            gridSwitch()
                        }) {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
                        }
                    }//:HSTACK
                    .padding(.bottom)
                } //:BUTTONS
            } //:TOOLBAR
        }//:NAVIGATION
    }//:BODY
    
    //MARK: - FUNCTIONS
    
    func gridSwitch() {
        withAnimation(.easeIn) {
            if horizontalSizeClass == .compact {
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.verticalSpacing), count: gridLayout.count % 2 + 1)
                gridColumn = gridLayout.count
            } else {
                gridLayout = Array(repeating: .init(.flexible(), spacing: Constants.verticalSpacing), count: gridLayout.count % 3 + 2)
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
    @Previewable @State var selectedTab = MainView.Tabs.itinerary
    
    ItineraryView(selectedTab: $selectedTab, itinerary: SampleItineraryData.sampleItineraries.first)
    
}
