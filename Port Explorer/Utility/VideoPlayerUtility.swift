//
//  VideoPlayerUtility.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import Foundation
import AVKit


var videoPlayer: AVPlayer?

func playVideo(fileName: String, fileFormat: String) -> AVPlayer? {
    if let safeURL = Bundle.main.url(forResource: fileName, withExtension: fileFormat) {
        let videoPlayer = AVPlayer(url: safeURL)
        videoPlayer.play()
        return videoPlayer
    } else {
        print("Error: Video file \(fileName).\(fileFormat) not found in the bundle.")
        return nil
    }
}
