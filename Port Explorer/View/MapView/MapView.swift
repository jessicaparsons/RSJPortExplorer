//
//  MapView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/16/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var cameraPosition: MapCameraPosition = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MapCameraPosition.region(MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel))
        return mapRegion
    }()
    
    let locations: [PortLocation] = Bundle.main.decode("locations.json")
    @State private var selection: String?
    @State private var latitude: String = "6.600286"
    @State private var longitude: String = "16.4377599"
    
    var body: some View {

        Map(position: $cameraPosition, selection: $selection) {
            ForEach(locations) { location in
                Annotation(location.name, coordinate: location.location) {
                    MapAnnotationView()
               }
            }//:LOOP
        }//:MAP
        .overlay(
            HStack(alignment: .center, spacing: 12) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48, alignment: .center)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("Latitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    Divider()
                    
                    HStack {
                        Text("Longitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
            }//:HSTACK
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                Color.black
                    .cornerRadius(8)
                    .opacity(0.6)
            )
            .padding()
            , alignment: .top
        )//:OVERLAY
        .onMapCameraChange(frequency: .continuous) {
            MapCameraUpdateContext in
            let latitudeRounded = String(format: "%.6f", Double(MapCameraUpdateContext.region.center.latitude))
            let longitudeRounded = String(format: "%.6f", Double(MapCameraUpdateContext.region.center.longitude))
            latitude = "\(latitudeRounded)"
            longitude = "\(longitudeRounded)"
        }
    }
}

#Preview {
    MapView()
}
