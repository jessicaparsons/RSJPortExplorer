//
//  HomeView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/21/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = CruiseViewModel()
    @State private var navigateToMapView: Bool = false
    
    let horizontalSizeClass: UserInterfaceSizeClass?
    
    private var itineraries: [Itinerary] {
        !viewModel.itinerary.isEmpty ? viewModel.itinerary : []
    }
    
    init(horizontalSizeClass: UserInterfaceSizeClass?) {
        self.horizontalSizeClass = horizontalSizeClass
    }
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                VStack(spacing: Constants.verticalSpacing) {
                    //MARK: - TITLE
                    HStack(alignment: .center, spacing: 10) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("Port Explorer")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top)
                    
                    //MARK: - IMAGE CAROUSEL
                    CoverImageView()
                        .frame(height: Constants.photoBannerHeight)
                    
                    Group { //FOR PADDING
                        
                        //MARK: - HORIZONTAL GALLERIES
                        
                        if itineraries.isEmpty {
                            ProgressView("Loading Itineraries...")
                            
                        } else {
                            
                            ItineraryHorizontalGalleryView(
                                title: "Top-Rated Itineraries",
                                image: "star",
                                itineraries: itineraries,
                                horizontalSizeClass: horizontalSizeClass,
                                numberOfItineraries: 3,
                                isPrefix: true
                            )
                            
                            ItineraryHorizontalGalleryView(
                                title: "Family Friendly Favorites",
                                image: "figure.2.and.child.holdinghands",
                                itineraries: itineraries,
                                horizontalSizeClass: horizontalSizeClass,
                                numberOfItineraries: 2,
                                isPrefix: false
                            )
                        }
                        
                        //MARK: - MAP
                        
                        Group {
                            VStack(spacing: 5) {
                                HeadingView(headingImage: "map", headingText: "Our Ports Around the World")
                                NavigationLink(destination: MapView()) {
                                    HStack {
                                        Text("Full screen map")
                                            .multilineTextAlignment(.center)
                                        Image(systemName: "arrow.up.right.square")
                                            .foregroundColor(.accentColor)
                                            .imageScale(.large)
                                    }//:HSTACK
                                }//:NAVIGATIONLINK
                            }
                            Group {
                                MapView()
                            }
                            .frame(height: Constants.photoBannerHeight * 2)
                            .cornerRadius(Constants.cornerRadius)
                        }
                    }//:GROUP FOR PADDING
                    .padding(.horizontal)
                    
                    //MARK: - CREDITS
                    CreditsView()
                    
                }//:VSTACK
                
            }//:SCROLL
            .navigationTitle("Royal Sea Journeys")
            .navigationBarTitleDisplayMode(.inline)
        }//:NAV
        .task {
            await viewModel.fetchCruiseData()
        }
    }//:BODY
}


#Preview {
    
    @Previewable @State var selectedTab = MainView.Tabs.itinerary
    
    HomeView(horizontalSizeClass: .compact)
    
}
