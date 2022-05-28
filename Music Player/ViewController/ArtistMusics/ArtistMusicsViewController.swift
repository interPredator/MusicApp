//
//  ArtistMusicsViewController.swift
//  Music Player
//
//  Created by Sevak on 15.01.22.
//

import UIKit
import MarqueeLabel

class ArtistMusicsViewController: UIViewController {

    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    @IBOutlet weak var artistImageView: UIImageView!
    var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        artistNameLabel.text = artist.artistName
    }
    
    @IBAction func changeDetailType(_ sender: Any) {
        
    }
    
}

