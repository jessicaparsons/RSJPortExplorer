//
//  InsetMapView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI
import MapKit

struct InsetMapView: View {
    
    let port: Port
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)))
    
    
    var body: some View {
        Map(position: $cameraPosition) {
            Annotation(port.name, coordinate: port.location.coordinates) {
                MapAnnotationView()
           }
        }
        .onAppear {
            cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)))
        }
        .overlay(
            NavigationLink(destination: MapView()) {
                HStack {
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.accentColor)
                        .imageScale(.large)
                    Text("All Ports")
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                }//:HSTACK
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(
                    Color.black
                        .opacity(0.4)
                        .cornerRadius(8)
                )
            }//:NAV
            .padding(12)
            , alignment: .topTrailing
        )
        .frame(height: Constants.photoBannerHeight)
        .cornerRadius(Constants.cornerRadius)
    }
}

#Preview {
    
    @Previewable @State var selectedTab = MainView.Tabs.itinerary
    
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        InsetMapView(port: port, latitude: 6.600286, longitude: 16.4377599)
    } else {
       Text("error")
    }
    
}
