//
//  FavoritesViewCell.swift
//  Music Player
//
//  Created by Sevak on 02.01.22.
//

import UIKit
import SDWebImage
import MarqueeLabel

class FavoritesViewCell: CollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var songNameLabel: MarqueeLabel!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    @IBOutlet weak var albumNameLabel: MarqueeLabel!
    @IBOutlet weak var favoriteUnfavoriteButton: UIButton!
    
    var music: Music!
    var favoriteUnfavoriteMode: FavoriteUnfavoriteMode = .unfavorited {
        didSet {
            switch favoriteUnfavoriteMode {
            case .unfavorited:
                favoriteUnfavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            case .favorited:
                favoriteUnfavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        self.layer.cornerRadius = 10
        artistImageView.layer.cornerRadius = 10
        view.layer.cornerRadius = 10
    }
    
    func configure(with music: Music) {
        if let url = URL(string: music.artworkUrl100) {
            artistImageView.sd_setImage(with: url)
        }
        songNameLabel.text = "Track: \(music.trackName)"
        artistNameLabel.text = "Artist: \(music.artistName) (\(music.country))"
        albumNameLabel.text = "Album: \(music.collectionName)"
    }
    
    @IBAction func favoriteUnfavoriteTrack() {
        favoriteUnfavoriteMode = favoriteUnfavoriteMode == .unfavorited ? .favorited : .unfavorited
        if favoriteUnfavoriteMode == .unfavorited {
            let vc = PlayerManagerViewController(nibName: "PlayerManagerViewController", bundle: nil)
            vc.music = music
            NotificationCenter.default.post(name: NSNotification.Name("UnfavoriteTrack"), object: music)
            music.isFavorited = false
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("FavoriteTrack"), object: music)
            music.isFavorited = true

        }
    }
}
