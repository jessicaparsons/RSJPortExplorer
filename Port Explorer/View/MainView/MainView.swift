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
    @StateObject var viewModel = CruiseViewModel()
    
    enum Tabs: Equatable, Hashable {
        case itinerary
        case watch
        case settings
        case gallery
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Browse", systemImage: "square.grid.2x2", value: .itinerary) {
                HomeView(horizontalSizeClass: horizontalSizeClass)
            }
            .accessibilityLabel("Browse")
            .accessibilityHint("Explore itineraries and destinations.")
            
            Tab("Videos", systemImage: "play.rectangle", value: .watch) {
                VideoGalleryView(selectedTab: $selectedTab)
                    
            }
            .accessibilityLabel("Port Videos")
            .accessibilityHint("Explore videos of our destinations.")
            
            Tab("Gallery", systemImage: "photo", value: .gallery) {
                GalleryView(horizontalSizeClass: horizontalSizeClass)
                    
            }
            .accessibilityLabel("Photo Gallery")
            .accessibilityHint("See stunning photos of our ports.")
            
            
            Tab("Book Now", systemImage: "suitcase", value: .settings) {
                SettingsView()
                    
            }
            .accessibilityLabel("Book now")
            .accessibilityHint("Book your next cruise or contact us.")
            
        }//:TAB
        .onAppear {
            prefetchImages()
        }
        .environmentObject(viewModel)
    }
    
    @MainActor
    func prefetchImages() {
        let imageUrls = viewModel.itinerary.flatMap { itinerary in
            [itinerary.image] + itinerary.portsOfCall.flatMap { [$0.image] + $0.gallery }
        }.compactMap { URL(string: $0) }
        
        ImagePrefetcher(urls: imageUrls).start()
    }
    
}

#Preview {
    MainView()
}
