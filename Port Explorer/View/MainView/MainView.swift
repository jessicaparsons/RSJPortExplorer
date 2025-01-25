//
//  MainView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectedTab: Tabs = .itinerary
    @StateObject var cruiseViewModel = CruiseViewModel()
    
    enum Tabs: Equatable, Hashable {
        case itinerary
        case watch
        case settings
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
            
            Tab("Settings", systemImage: "gear", value: .settings) {
                SettingsView()
                    
            }
            
            Tab("Gallery", systemImage: "photo", value: .gallery) {
                GalleryView(horizontalSizeClass: horizontalSizeClass)
                    
            }
        }//:TAB
        .onAppear {
            prefetchImages()
        }
    }
    
    func prefetchImages() {
        let imageUrls = cruiseViewModel.itinerary.flatMap { itinerary in
            [itinerary.image] + itinerary.portsOfCall.flatMap { [$0.image] + $0.gallery }
        }.compactMap { URL(string: $0) }
        
        ImagePrefetcher(urls: imageUrls).start()
    }
    
}

#Preview {
    MainView()
}
