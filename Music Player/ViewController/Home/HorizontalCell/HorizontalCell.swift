//
//  ArtistCell.swift
//  Music Player
//
//  Created by Sevak on 06.01.22.
//

import UIKit
import SDWebImage
import MarqueeLabel

class HorizontalCell: CollectionViewCell {

    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configureUI() {
        view.layer.cornerRadius = 10
        artistImageView.layer.cornerRadius = 10
    }
    
    func configureArtist(with artist: Artist) {
        artistNameLabel.font = UIFont(name: "System", size: 50)
        
        artistNameLabel.text = artist.artistName + "   "
    }
    func configureAlbum(with album: Album) {
        if let url = URL(string: album.artworkUrl100) {
            artistImageView.sd_setImage(with: url)
        }
        artistNameLabel.text = album.artistName + "   "
    }
}
