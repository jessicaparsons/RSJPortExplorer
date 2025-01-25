//
//  FullScreenImageView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/24/25.
//

import SwiftUI
import Kingfisher

struct FullScreenImageView: View {
    @Environment(\.dismiss) private var dismiss
    
    let imageURL: String
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                if let url = URL(string: imageURL) {
                    KFImage(url)
                        .placeholder {
                            PlaceholderImageView()
                        }
                        .onFailure { error in
                            print("Failed to load full-screen image: \(error.localizedDescription)")
                        }
                        .cacheOriginalImage()
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Image Not Available")
                        .foregroundColor(.white)
                }
            }//:ZSTACK
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(.white)
                    }
                }
            }
            .onTapGesture {
                dismiss()
            }
        }//:NAVIGATIONSTACK
    }
    
    
}
#Preview {
    let image = "https://junipercreative.co/wp-content/uploads/2025/01/ocho_rios1.jpg"
    NavigationStack {
        FullScreenImageView(imageURL: image)
    }
}
