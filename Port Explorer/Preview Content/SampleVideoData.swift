//
//  SampleVideoData.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/23/25.
//

import Foundation

struct SampleVideoData: Decodable {
    
    static let sampleVideos: [PixabayVideo] = [
        PixabayVideo(
            id: 3713,
            pageURL: "https://pixabay.com/videos/id-3713/",
            type: "film",
            tags: "cruise ship, cruises, harbour, ship, sea, port, transport, coast, boat, vessel",
            duration: 20,
            videos: VideoFormats(
                large: VideoFormat(
                    url: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_large.mp4",
                    width: 1920,
                    height: 1080,
                    size: 11749650,
                    thumbnail: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_large.jpg"
                ),
                medium: VideoFormat(
                    url: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_medium.mp4",
                    width: 1280,
                    height: 720,
                    size: 6852157,
                    thumbnail: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_medium.jpg"
                ),
                small: VideoFormat(
                    url: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_small.mp4",
                    width: 960,
                    height: 540,
                    size: 4290839,
                    thumbnail: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_small.jpg"
                ),
                tiny: VideoFormat(
                    url: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_tiny.mp4",
                    width: 640,
                    height: 360,
                    size: 1548442,
                    thumbnail: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_tiny.jpg"
                )
            ),
            views: 108268,
            downloads: 53912,
            likes: 415,
            comments: 98,
            user_id: 1846871,
            user: "bellergy",
            userImageURL: "https://cdn.pixabay.com/user/2021/10/22/09-52-10-903_250x250.png"
        )
    ]
}
