//
//  HeadingView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import SwiftUI

struct HeadingView: View {

    var headingImage: String
    var headingText: String

    var body: some View {
        HStack {
            Image(systemName: headingImage)
                .foregroundColor(.accent)
                .imageScale(.large)
            
            Text(headingText)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
        }//:HSTACK
    }
}

#Preview {
    HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Wilderness in pictures")
}
