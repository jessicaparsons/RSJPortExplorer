//
//  ExternalWebLinkView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI

struct ExternalWebLinkView: View {
    
    let port: Port
    
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "globe")
                Text("Wikipedia")
                Spacer()
                
                Group {
                    if let safeURL = URL(string: port.link) {
                        Link(port.name, destination: safeURL)
                    } else if let fallbackURL = URL(string: "https://wikipedia.org") {
                        Link(port.name, destination: fallbackURL)
                    }
                    
                    Image(systemName: "arrow.up.right.square")
                }
                .foregroundColor(.accentColor)
            }//:HSTACK
        }//:BOX
    }
}

#Preview {
    if let itinerary = SampleItineraryData.sampleItineraries.first,
       let port = itinerary.portsOfCall.first {
        ExternalWebLinkView(port: port)
    } else {
        Text("error")
    }
    
}


