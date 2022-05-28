//
//  HomeCollectionViewCell.swift
//  Music Player
//
//  Created by Sevak on 05.01.22.
//

import UIKit
import SDWebImage
import MarqueeLabel
class TrackCell: CollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trackName: MarqueeLabel!
    @IBOutlet weak var albumName: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        imageView.layer.cornerRadius = 10
    }
    
    func configure(with music: Music) {
        if let url = URL(string: music.artworkUrl100) {
            imageView.sd_setImage(with: url)
        }
        trackName.text = music.trackName + "   "
        albumName.text = music.artistName + "   "
    }
}
