//
//  VideoListItem.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI
import Kingfisher

struct VideoListItemView: View {
    
    let video: PixabayVideo
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                if let url = URL(string: video.videos.small.thumbnail) {
                    KFImage(url)
                        .placeholder {
                            PlaceholderImageView()
                        }
                        .onFailure { error in
                            print("Failed to load itinerary image: \(error.localizedDescription)")
                        }
                        .resizable()
                        .cacheOriginalImage()
                        .aspectRatio(16/9, contentMode: .fit)
                        .cornerRadius(Constants.cornerRadius)
                        .accessibilityLabel("Video thumbnail image")
                } else {
                    FailureImageView(width: nil, height: Constants.photoBannerHeight)
                }
            }//:ZSTACK
            .overlay {
                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                    .shadow(radius: 4)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    let videos = SampleVideoData.sampleVideos
    
    if let video = videos.first {
        VideoListItemView(video: video)
    }
}
