//
//  LiveAudioPlayer.swift
//  iAccessibility
//
//  Created by Michael Doise on 1/27/23.
//

import Foundation
import SwiftUI
import AVFoundation
import AVKit
import MediaPlayer

class LiveAudioPlayer: ObservableObject {
    @Published var player: AVPlayer?
    
    func play(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting audio session category: \(error)")
        }
        let commandCenter = MPRemoteCommandCenter.shared()
            
            commandCenter.playCommand.isEnabled = true
            commandCenter.playCommand.addTarget { [unowned self] event in
                if player!.rate == 0 {
                    player!.play()
                    return .success
                }
                return .commandFailed
            }
            
            commandCenter.pauseCommand.isEnabled = true
            commandCenter.pauseCommand.addTarget { [unowned self] event in
                if player!.rate > 0 {
                    player!.pause()
                    return .success
                }
                return .commandFailed
            }
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "iACast Network Live"
        let imageURL = URL(string: "https://iacast.net/wp-content/uploads/2022/12/cropped-icon1024-1.png")!
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                guard let data = data, let image = UIImage(data: data) else { return }
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (_) -> UIImage in
                    return image
                })
                MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            }
            task.resume()
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
