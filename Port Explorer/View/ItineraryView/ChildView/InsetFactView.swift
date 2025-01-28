//
//  InsetFactView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI

struct InsetFactView: View {
    
    let port: Port
    
    var body: some View {
        GroupBox {
            TabView {
                ForEach(port.facts, id: \.self) { item in
                    Text(item)
                        .multilineTextAlignment(.center)
                }
            }//:TABS
            .tabViewStyle(PageTabViewStyle())
            .frame(minHeight: Constants.photoBannerHeight * 0.5, idealHeight: 168, maxHeight: 180)
        }//:BOX
    }
}

#Preview {
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        InsetFactView(port: port)
    } else {
        Text("error")
    }
    
    
}
