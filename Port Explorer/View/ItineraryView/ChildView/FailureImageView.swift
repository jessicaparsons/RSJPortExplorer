//
//  FailureImageView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/21/25.
//

import SwiftUI

struct FailureImageView: View {
    
    let width: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "slash.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(.systemRed).opacity(0.5))
                    .accessibilityLabel("Photo failed to load icon")
            }
        }
        .frame(maxWidth: width ?? .infinity, maxHeight: height ?? .infinity) // Match the image frame if desired
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    FailureImageView(width: nil, height: nil)
}
