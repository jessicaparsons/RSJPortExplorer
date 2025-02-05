//
//  VideoGalleryRowView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/23/25.
//

import SwiftUI

struct VideoGalleryRowView: View {
    
    @StateObject var viewModel = VideoGalleryViewModel()
    let galleryTitle: String
    let searchTerm: String
    
    var body: some View {
        Group {
            if let videos = viewModel.videosBySearchTerm[searchTerm], !videos.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: Constants.gridSpacing) {
                        ForEach(videos.prefix(4)) { video in
                            NavigationLink(destination: VideoPlayerView(videoURL: video.videos.small.url, videoTitle: galleryTitle)) {
                                VideoListItemView(video: video)
                                    .frame(width: Constants.galleryHeight * 1.5)
                            }
                        }//:LOOP
                    }
                }//:SCROLLVIEW
                
            } else {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "video.slash")
                            .font(.headline)
                        Text("Sorry, no videos found")
                    }
                    .foregroundColor(Color(UIColor.systemGray))
                    Spacer()
                }
            }
        }//:GROUP
        .task {
            await viewModel.fetchVideoData(for: searchTerm)
        }
    }
}

#Preview {
    VideoGalleryRowView(galleryTitle: "Cruises Abroad", searchTerm: "europe")
}
