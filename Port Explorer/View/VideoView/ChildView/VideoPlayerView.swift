//
//  VideoPlayerView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    @State private var player: AVPlayer? = nil
    var videoURL: String
    var videoTitle: String
    
    var body: some View {
        
        VStack {
            if let player = player {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                    }
            } else {
                ProgressView("Loading Video...")
            }
        }//:VSTACK
        .accentColor(.accentColor)
        .navigationBarTitle(videoTitle, displayMode: .inline)
        .onAppear {
            preloadVideo()
        }
    }
    
    //MARK: - FUNCTIONS
    
    private func preloadVideo() {
        guard let validURL = URL(string: videoURL) else {
            print("Invalid video URL")
            return
        }
        
        let asset = AVURLAsset(url: validURL)
        
        
        Task {
            do {
                //asynchrously load the "playable" property
                let isPlayable = try await asset.load(.isPlayable)
                let preferredTransform = try await asset.load(.preferredTransform)
                
                guard isPlayable else {
                    print("The asset is not playable")
                    return
                }
                
                print("Preferred transform loaded: \(preferredTransform)")
                
                let item = AVPlayerItem(asset: asset)
                    
                //if successful, set up the player
                
                await MainActor.run {
                    if self.player == nil {
                        self.player = AVPlayer(playerItem: item)
                    } else {
                        self.player?.replaceCurrentItem(with: item)
                    }
                }
                
            } catch {
                print("Failed to load video asset: \(error.localizedDescription)")
            }
        }//:TASK
    }//:FUNCTION
}

#Preview {
    
    VideoPlayerView(
        videoURL: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_large.mp4",
        videoTitle: "Cruise"
    )
    
}
