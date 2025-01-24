//
//  EmptyStateView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/21/25.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.accentColor)
            Text(text)
        }
    }
}

#Preview {
    EmptyStateView(icon: "map", text: "Select an itinerary from the side bar")
}
