//
//  PlayerManager.swift
//  Music Player
//
//  Created by Sevak on 25.01.22.
//

import Foundation
import AVFoundation

protocol PlayerManagerDelegate: AnyObject {
    func playerManager(_ manager: PlayerManager, isChanging time: Double)
    func playerManagerDidEndPlaying(_ manager: PlayerManager)

}

class PlayerManager {
    
    weak var delegate: PlayerManagerDelegate?
    var music: Music!
    var player: AVPlayer!
    let vol = AVAudioSession.sharedInstance().outputVolume

    var duration: Double {
        if let playerItem = player.currentItem {
            return playerItem.asset.duration.seconds
        }
        return 0
    }
    var changingTime: Double = 0
    
    var currentTime: Double {
        if let playerItem = player.currentItem {
            return playerItem.currentTime().seconds
        }
        return changingTime
    }
    
    init(music: Music) {
        self.music = music
        guard let url = URL(string: music.previewUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.volume = vol
    }
    
    // MARK: - Methods
    func play(with music: Music) {
        if self.music != nil {
            player.play()
        }
        player.play()
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: nil) { [weak self] time in
            guard let self = self else { return }
            let seconds = time.seconds
            self.delegate?.playerManager(self, isChanging: seconds)
            if seconds == self.duration {
                self.delegate?.playerManagerDidEndPlaying(self)
            }
        }
    }
    
    func pause() {
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    func backward() {
        player.seek(to: CMTime(seconds: Double(currentTime - 10), preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
    
    func forward() {
        player.seek(to: CMTime(seconds: Double(currentTime + 10), preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
    func seekTime(to time: Double) {
        player.seek(to: CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
}
