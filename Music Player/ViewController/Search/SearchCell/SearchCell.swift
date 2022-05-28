//
//  SearchCell.swift
//  Music Player
//
//  Created by Sevak on 21.01.22.
//

import UIKit
import MarqueeLabel
import SDWebImage
class SearchCell: CollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var songNameLabel: MarqueeLabel!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        view.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        artistImageView.layer.cornerRadius = 10
    }
    
    func configure(with music: Music) {
        if let url = URL(string: music.artworkUrl100) {
            artistImageView.sd_setImage(with: url)
        }
        songNameLabel.text = music.trackName
        artistNameLabel.text = music.artistName
    }
    
}
