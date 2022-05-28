//
//  HeaderView.swift
//  Music Player
//
//  Created by Sevak on 13.01.22.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with section: HomeSectionType) -> String {
        titleNameLabel.text = section.sectionTitle
        switch section {
        case .artist:
            return "Artists"
        case .album:
            return "Albums"
        case .tracks:
            return "Tracks"
        }
    }
}
