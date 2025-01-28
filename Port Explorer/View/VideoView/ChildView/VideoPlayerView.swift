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
    @State private var isPreloading = false

    var videoURL: String
    var videoTitle: String
    
    var body: some View {
        
        VStack {
            if let player = player {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                    }
                    .onDisappear {
                        AVPlayer(url: URL(string: videoURL)!).pause()
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
    
    private func preloadVideo(retryCount: Int = 3) {
        guard let validURL = URL(string: videoURL), !isPreloading else {
            print("Preload skipped: Already in progress or invalid URL")
            return
        }
        
        isPreloading = true
        let asset = AVURLAsset(url: validURL)
        
        
        Task {
            do {
                //asynchrously load the "playable" property
                let isPlayable = try await asset.load(.isPlayable)
                    if isPlayable {
                        print("Video is playable: \(validURL)")
                    } else {
                        print("Video is not playable: \(validURL)")
                    }
                let preferredTransform = try await asset.load(.preferredTransform)
                
                guard isPlayable else {
                    print("The asset is not playable")
                    return
                }
                
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
                if retryCount > 0 {
                    print("Retrying video preload (\(retryCount) retries left)...")
                    preloadVideo(retryCount: retryCount - 1)
                } else {
                    print("Failed to load video asset: \(error.localizedDescription)")
                }
            }
            isPreloading = false
        }//:TASK
    }//:FUNCTION
}

#Preview {
    
    VideoPlayerView(
        videoURL: "https://cdn.pixabay.com/video/2016/07/05/3713-173505175_small.mp4",
        videoTitle: "Cruise"
    )
    
}
