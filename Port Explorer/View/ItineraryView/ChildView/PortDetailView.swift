//
//  PortDetailView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import SwiftUI
import Kingfisher

struct PortDetailView: View {
    
    @Binding var selectedTab: MainView.Tabs
    let port: Port
    
    
    //MARK: - BODY
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    //MARK: - HERO IMAGE
                    
                    BannerImageView(image: port.image)
                    
                    //MARK: - TITLE
                    Group { //PADDING
                        Text(port.name.uppercased())
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 8)
                            .foregroundColor(.primary)
                            .overlay(
                                Rectangle()
                                    .fill(Color.accentColor)
                                    .frame(height: 6)
                                    .offset(y: 0),
                                alignment: .bottom
                            )
                        
                        //MARK: - HEADLINE
                        Text(port.headline)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.accentColor)
                        
                        //MARK: - GALLERY
                        Group {
                            HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Sights and Scenes")
                            InsetGalleryView(port: port)
                        }
                        
                        //MARK: - MAP
                        Group {
                            HeadingView(headingImage: "map", headingText: "Location")
                            InsetMapView(selectedTab: $selectedTab, port: port, latitude: port.location.latitude, longitude: port.location.longitude)
                        }
                        
                        
                        //MARK: - FUN FACTS
                        Group {
                            HeadingView(headingImage: "questionmark.bubble", headingText: "Did you know?")
                            InsetFactView(port: port)
                        }
                        
                        //MARK: - DESCRIPTION
                        Group {
                            HeadingView(headingImage: "book", headingText: "All about \(port.name)")
                            Text(port.description)
                                .multilineTextAlignment(.leading)
                                .layoutPriority(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        //MARK: - LINK
                        Group {
                            HeadingView(headingImage: "globe.europe.africa", headingText: "Learn more")
                            ExternalWebLinkView(port: port)
                        }
                    }//:EXTERNAL GROUP
                    .padding(.horizontal)
                    .padding(.bottom)
                }//:VSTACK
                .navigationBarTitle("Learn about \(port.name)", displayMode: .inline)
            }//:SCROLL
        }//:NAV
    }
}

//MARK: - PREVIEW
#Preview {
    
    @Previewable @State var selectedTab = MainView.Tabs.itinerary
    
    
    
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        PortDetailView(selectedTab: $selectedTab, port: port)
    } else {
        Text("error")
    }
    
    
}
