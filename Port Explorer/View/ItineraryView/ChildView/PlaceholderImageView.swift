//
//  PlaceholderImageView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/21/25.
//

import SwiftUI

struct PlaceholderImageView: View {
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height) // Match the image frame if desired
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
}

#Preview {
    PlaceholderImageView()
}
