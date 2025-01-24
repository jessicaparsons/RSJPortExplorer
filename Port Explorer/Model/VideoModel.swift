//
//  VideoModel.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import Foundation


struct PixabayVideoResponse: Codable {
    let total: Int
    let totalHits: Int
    let hits: [PixabayVideo]
}

struct PixabayVideo: Codable, Identifiable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let duration: Int
    let videos: VideoFormats
    let views: Int
    let downloads: Int
    let likes: Int
    let comments: Int
    let user_id: Int
    let user: String
    let userImageURL: String
}

struct VideoFormats: Codable {
    let large: VideoFormat
    let medium: VideoFormat
    let small: VideoFormat
    let tiny: VideoFormat
}

struct VideoFormat: Codable {
    let url: String
    let width: Int
    let height: Int
    let size: Int
    let thumbnail: String
}

//struct Video: Codable, Identifiable, Hashable {
//    let id: String
//    let name: String
//    let headline: String
//    
//    // Computed Property
//    var thumbnail: String {
//        "video-\(id)"
//    }
//}
