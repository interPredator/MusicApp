//
//  PlayerManagerViewController.swift
//  Music Player
//
//  Created by Sevak on 05.01.22.
//

import UIKit
import AVFoundation
import MarqueeLabel

enum PlayPauseMode {
    case play
    case pause
}

enum FavoriteUnfavoriteMode {
    case favorited
    case unfavorited
}

enum RepeatMode {
    case repeatIsOn
    case repeatIsOff
}

class PlayerManagerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var trackName: MarqueeLabel!
    @IBOutlet weak var artistName: MarqueeLabel!
    @IBOutlet weak var trackProgress: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durrationLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var pauseResumeButton: UIButton!
    @IBOutlet weak var previousTrackButton: UIButton!
    @IBOutlet weak var nextTrackButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    // MARK: - Properties
    var music: Music!
    var viewModel: PlayerManagerViewModel!
    var shuffle: Bool!
    var repeats: Bool!
    var isTimeChanging: Bool!
    var playPauseMode: PlayPauseMode = .pause {
        didSet {
            viewModel.playerManager?.play(with: music)
            switch playPauseMode {
            case .pause:
                pauseResumeButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                viewModel.playerManager?.pause()
            case .play:
                pauseResumeButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                viewModel.playerManager?.play()
            }
        }
    }
    
    var favoriteUnfavoriteMode: FavoriteUnfavoriteMode = .favorited {
        didSet {
            switch favoriteUnfavoriteMode {
            case .favorited:
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            case .unfavorited:
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    var currentTime: String {
        let currentTime = Int(viewModel.playerManager?.changingTime ?? 0)
        let seconds = currentTime % 60
        let minutes = (currentTime / 60) % 60
        let time = String(format: "%02i:%02i", minutes, seconds)
        return time
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        isTimeChanging = false
        shuffle = false
        repeats = false
        getSystemVolume()
        notifications()
        updateTrackInfo()
        updateButtonState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        artistImageView.layer.cornerRadius = 10
    }
    
    // MARK: - Methods
    func notifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteTrack), name: NSNotification.Name("FavoritedFromFavoritesViewCell"), object: music)
        NotificationCenter.default.addObserver(self, selector: #selector(unfavoriteTrack), name: NSNotification.Name("UnfavoritedFromFavoritesViewCell"), object: music)
        NotificationCenter.default.addObserver(self, selector: #selector(unfavoriteTrack), name: NSNotification.Name("UnfavoriteTrack"), object: music)
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteTrack), name: NSNotification.Name("FavoriteTrack"), object: music)
    }
    
    @objc func favoriteTrack(_ notification: Notification) {
        if let _ = notification.object as? Music {
            favoriteUnfavoriteMode = .favorited
        }
    }
    
    @objc func unfavoriteTrack(_ notification: Notification) {
        if let _ = notification.object as? Music {
            favoriteUnfavoriteMode = .unfavorited
        }
    }
    
    func getSystemVolume() {
        volumeSlider.value = viewModel.playerManager?.vol ?? 0.0
        
    }
    
    func updateTrackInfo() {
        self.music = viewModel.music
        if let url = URL(string: music.artworkUrl100) {
            artistImageView.sd_setImage(with: url)
        }
        trackName.text = music.trackName + "   "
        artistName.text = music.artistName + "   "
        currentTimeLabel.text = 0.timeString
        durrationLabel.text = Int(viewModel.playerManager?.duration ?? 0).timeString
        trackProgress.minimumValue = 0
        trackProgress.value = 0
        trackProgress.maximumValue = Float(viewModel.playerManager?.duration ?? 0)
        viewModel.playerManager?.delegate = self
    }
    
    func updateButtonState() {
        shuffleButton.isSelected = shuffle
        previousTrackButton.isEnabled = viewModel.index > 0
        nextTrackButton.isEnabled = viewModel.index < viewModel.musics.count - 1
        if music.isFavorited {
            favoriteUnfavoriteMode = .favorited
        } else {
            favoriteUnfavoriteMode = .unfavorited
        }
        if shuffleButton.isSelected {
            previousTrackButton.isEnabled = true
            nextTrackButton.isEnabled = true
        }
        
        if repeatButton.isSelected {
            previousTrackButton.isEnabled = true
            nextTrackButton.isEnabled = true
        }
    }
    
    // MARK: - Actions
    @IBAction func backward() {
        viewModel.playerManager?.backward()
        trackProgress.value -= 10
        currentTimeLabel.text = Int(trackProgress.value).timeString
    }
    
    @IBAction func forward() {
        viewModel.playerManager?.forward()
        trackProgress.value += 10
        currentTimeLabel.text = Int(trackProgress.value).timeString
    }
    
    @IBAction func pauseResume() {
        playPauseMode = playPauseMode == .play ? .pause : .play
    }
    
    @IBAction func favoriteUnfavorite(_ sender: UIButton) {
        favoriteUnfavoriteMode = favoriteUnfavoriteMode == .favorited ? .unfavorited : .favorited
        music.isFavorited.toggle()
        if favoriteUnfavoriteMode == .favorited {
            NotificationCenter.default.post(name: NSNotification.Name("Favorited"), object: music)
        } else  {
            NotificationCenter.default.post(name: NSNotification.Name("Unfavorited"), object: music)
        }
    }
    
    @IBAction func adjustVolume(_ sender: UISlider) {
        viewModel.playerManager?.player?.volume = sender.value
        
    }
    
    @IBAction func changeTrackTime(_ sender: UISlider, forEvent event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                isTimeChanging = true
            case .moved:
                isTimeChanging = true
            case .ended:
                isTimeChanging = false
            default:
                return
            }
        }
        viewModel.playerManager?.seekTime(to: Double(sender.value))
        currentTimeLabel.text = Int(sender.value).timeString
    }

    
    
    @IBAction func changeToNextTrack(_ sender: UIButton) {
        playPauseMode = .pause
        if shuffle && repeats {
            viewModel.shuffle()
        } else if !shuffle && !repeats {
            viewModel.next()
        } else if repeats && !shuffle {
            viewModel.repeatListNext()
        } else if shuffle && !repeats {
            viewModel.shuffle()
        }
        updateTrackInfo()
        updateButtonState()
}

@IBAction func changeToPreviousTrack(_ sender: UIButton) {
    playPauseMode = .pause
    if shuffle && repeats {
        viewModel.shuffle()
    } else if !shuffle && !repeats {
        viewModel.previous()
    } else if repeats && !shuffle {
        viewModel.repeatListPrevious()
    } else if shuffle && !repeats {
        viewModel.shuffle()
    }
    updateTrackInfo()
    updateButtonState()
}

@IBAction func shuffle(_ sender: Any) {
    shuffleButton.isSelected.toggle()
    shuffle.toggle()
    updateButtonState()
}

@IBAction func repeatList(_ sender: Any) {
    repeatButton.isSelected.toggle()
    repeats.toggle()
    updateButtonState()
}

}

extension PlayerManagerViewController: PlayerManagerDelegate {
    func playerManagerDidEndPlaying(_ manager: PlayerManager) {
        playPauseMode = .pause
        if shuffle && repeats {
            viewModel.shuffle()
        } else if !shuffle && !repeats {
            viewModel.next()
        } else if repeats && !shuffle {
            viewModel.repeatListNext()
        } else if shuffle && !repeats {
            viewModel.shuffle()
        }
        updateTrackInfo()
        updateButtonState()
    }
    
    func playerManager(_ manager: PlayerManager, isChanging time: Double) {
        if isTimeChanging == false {
        trackProgress.value = Float(time)
        }
        currentTimeLabel.text = Int(time).timeString
    }
    
    
}
