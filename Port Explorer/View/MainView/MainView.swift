//
//  MainView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: Tabs = .itinerary
    
    enum Tabs: Equatable, Hashable {
        case itinerary
        case watch
        case map
        case gallery
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Browse", systemImage: "square.grid.2x2", value: .itinerary) {
               HomeView(selectedTab: $selectedTab)
                    
               
            }
            Tab("Watch", systemImage: "play.rectangle", value: .watch) {
                VideoGalleryView(selectedTab: $selectedTab)
                    
            }
            
            Tab("Locations", systemImage: "map", value: .map) {
                MapView()
                    
            }
            
            Tab("Gallery", systemImage: "photo", value: .gallery) {
                GalleryView(selectedTab: $selectedTab)
                    
            }
        }//:TAB
    }
}

#Preview {
    MainView()
}
