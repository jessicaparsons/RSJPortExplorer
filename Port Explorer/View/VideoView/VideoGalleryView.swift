//
//  VideoGalleryView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/23/25.
//

import SwiftUI

struct VideoGalleryView: View {
  
    @Binding var selectedTab: MainView.Tabs
    
    let firstGalleryTerm: String = "cruises"
    let firstGalleryName: String = "Life Onboard"
    let secondGalleryTerm: String = "europe+street"
    let secondGalleryName: String = "Hidden Port Gems"
    let thirdGalleryTerm: String = "snorkeling"
    let thirdGalleryName: String = "Adventures At Sea"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.verticalSpacing) {
                    
                    GroupBox {
                        VStack(spacing: 8) {
                            Text("Discover the World Ashore")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("These videos were shared by fellow cruise travelers, capturing their unforgettable moments.")
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 8)
                            Button("Contact us to submit your video") {
                                HapticsManager.shared.triggerMediumImpact()
                                selectedTab = .settings
                            }
                            .buttonStyle(CapsuleButtonStyle())
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(Constants.horizontalPadding)
                    }
                    .frame(maxWidth: .infinity) // Make the GroupBox span the full width
                    
                    //MARK: - FIRST VIDEO GALLERY
                    Group {
                        HeadingView(headingImage: "water.waves", headingText: firstGalleryName)
                        VideoGalleryRowView(galleryTitle: firstGalleryName, searchTerm: firstGalleryTerm)
                    }//:GROUP
                    
                    //MARK: - SECOND VIDEO GALLERY
                    
                    Group {
                        HeadingView(headingImage: "star", headingText: secondGalleryName)
                        VideoGalleryRowView(galleryTitle: firstGalleryName, searchTerm: secondGalleryTerm)
                    }//:GROUP
                    
                    //MARK: - THIRD VIDEO GALLERY
                    
                    Group {
                        HeadingView(headingImage: "tortoise", headingText: thirdGalleryName)
                        VideoGalleryRowView(galleryTitle: firstGalleryName, searchTerm: thirdGalleryTerm)
                    }//:GROUP
                    
                }//:VSTACK
            }//:SCROLLVIEW
            .navigationTitle("Port Highlights")
            .navigationBarTitleDisplayMode(.inline)
        }//:NAVIGATION STACK
    }
}

#Preview {
    @Previewable @State var selectedTab = MainView.Tabs.watch
    VideoGalleryView(selectedTab: $selectedTab)
}
