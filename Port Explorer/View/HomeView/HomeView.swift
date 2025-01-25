//
//  HomeView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/21/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = CruiseViewModel()
    @Binding var selectedTab: MainView.Tabs
    @State private var navigateToMapView: Bool = false
    
    private var itineraries: [Itinerary] {
        !viewModel.itinerary.isEmpty ? viewModel.itinerary : []
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
                        .listRowInsets(EdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0))
                    
                    Group { //FOR PADDING
                        //MARK: - ITINERARY HORIZONTAL GALLERY
                        Group {
                            HeadingView(headingImage: "star", headingText: "Top-Rated Itineraries")
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(alignment: .center, spacing: Constants.gridSpacing) {
                                    ForEach(itineraries.prefix(3)) { itinerary in
                                        NavigationLink(destination:
                                                        ItineraryView(
                                                            viewModel: ItineraryViewModel(
                                                                        itinerary: itinerary,
                                                                        horizontalSizeClass: horizontalSizeClass)
                                                        )
                                        ) {
                                            ItineraryListItemView(itinerary: itinerary)
                                                .frame(width: Constants.galleryHeight * 1.5)
                                        }
                                    }//:LOOP
                                }//:LAZYHSTACK
                            }//:SCROLLVIEW
                        }//:GROUP
                        
                        //MARK: - ITINERARY GRID
                        Group {
                            HeadingView(headingImage: "figure.2.and.child.holdinghands", headingText: "Family Friendly Favorites")
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(alignment: .center, spacing: Constants.gridSpacing) {
                                    ForEach(itineraries.suffix(2)) { itinerary in
                                        NavigationLink(destination:
                                                        ItineraryView(
                                                            viewModel: ItineraryViewModel(
                                                                itinerary: itinerary,
                                                                horizontalSizeClass: horizontalSizeClass)
                                                        )
                                        ) {
                                            ItineraryListItemView(itinerary: itinerary)
                                                .frame(width: Constants.galleryHeight * 1.5)
                                        }
                                    }//:LOOP
                                }//:LAZYHSTACK
                            }//:GROUP
                            
                        }//:SCROLLVIEW
                        
                        //MARK: - MAP
                        
                        Group {
                            HStack {
                                Text("Our Ports Around the World")
                                Image(systemName: "arrow.up.right.square")
                                    .foregroundColor(.accentColor)
                                    .imageScale(.large)
                            }
                            Group {
                                MapView()
                            }
                            .frame(height: Constants.photoBannerHeight * 2)
                            .cornerRadius(Constants.cornerRadius)
                        }
                        
                        .onTapGesture {
                            navigateToMapView = true
                        }
                        .navigationDestination(isPresented: $navigateToMapView) {
                            MapView()
                                .edgesIgnoringSafeArea(.all) // Optional fullscreen behavior
                        }
                    }//:GROUP FOR PADDING
                    .padding(.horizontal)
                    
                    //MARK: - CREDITS
                    CreditsView()
                        .modifier(CenterModifier())
                    
                    
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
    
    HomeView(selectedTab: $selectedTab)
    
}
