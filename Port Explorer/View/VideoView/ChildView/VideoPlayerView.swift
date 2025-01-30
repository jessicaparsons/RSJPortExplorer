//
//  VideoPlayerView.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/19/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    @State private var player = AVPlayer()
    @State private var isPreloading = false
    @State private var isLoadingView = true
    @State private var isNotPlayable = false
    
    var videoURL: String
    var videoTitle: String
    
    var body: some View {
        
        VStack {
            if isLoadingView {
                ProgressView("Loading Video...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if isNotPlayable {
                EmptyStateView(icon: "video.slash", text: "Video is unavailable")
            } else {
                VideoPlayer(player: player)
                    .onAppear {
                        if player.currentItem == nil {
                            preloadVideo()
                        }
                        player.play()
                    }
                    .onDisappear {
                        player.pause()
                        player.replaceCurrentItem(with: nil)
                    }
            }
        }//:VSTACK
        .accentColor(.accentColor)
        .navigationBarTitle(videoTitle, displayMode: .inline)
        .onAppear {
            if player.currentItem == nil {
                preloadVideo()
            }
        }
        
    }
    
    //MARK: - FUNCTIONS
    
    private func preloadVideo(retryCount: Int = 3) {
        guard let validURL = URL(string: videoURL), !isPreloading else {
            print("Preload skipped: Already in progress or invalid URL")
            return
        }
        
        isLoadingView = true
        isPreloading = true
        isNotPlayable = false
        let asset = AVURLAsset(url: validURL)
        
        
        Task {
            do {
                //asynchrously load the "playable" property
                let isPlayable = try await asset.load(.isPlayable)
                
                    guard isPlayable else {
                        print("The asset is not playable: \(validURL)")
                        isLoadingView = false
                        isPreloading = false
                        isNotPlayable = true
                        return
                    }
                
                print("Video is playable: \(validURL)")
                
                // Load preferredTransform in a separate Task to avoid blocking the main thread
                Task.detached {
                    do {
                        _ = try await asset.load(.preferredTransform)
                    } catch {
                        print("Failed to load preferredTransform: \(error.localizedDescription)")
                    }
                }

                let item = AVPlayerItem(asset: asset)
                    
                //if successful, set up the player
                
                await MainActor.run {
                    if player.currentItem == nil {
                        player.replaceCurrentItem(with: item)
                    }
                    isLoadingView = false
                }
                
            } catch {
                if retryCount > 0 {
                    print("Retrying video preload (\(retryCount) retries left)...")
                    isPreloading = false
                    isLoadingView = true
                    try await Task.sleep(nanoseconds: UInt64(1.0 * Double(NSEC_PER_SEC)))  // ✅ Delay before retrying
                    preloadVideo(retryCount: retryCount - 1)
                    
                } else {
                    print("Failed to load video asset: \(error.localizedDescription)")
                    isNotPlayable = true
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
