//
//  HomeRouter.swift
//  Music Player
//
//  Created by Sevak on 17.01.22.
//

import Foundation
import UIKit

enum HomeCellSegue {
    case artistDetail(Artist)
    case playerManager([Music], Int)
}

protocol HomeCellRoutable: Routable where SegueType == HomeCellSegue, SourceType == HomeViewController {
    
}

struct HomeRouter: HomeCellRoutable {
    func perform(_ segue: HomeCellSegue, from source: HomeViewController) {
        switch segue {
        case .artistDetail(let artist):
            let vc = ArtistMusicsViewController(nibName: "ArtistMusicsViewController", bundle: nil)
            vc.artist = artist
            source.present(vc, animated: true)
        case let .playerManager(musics, index):
            let vc = PlayerManagerViewController(nibName: "PlayerManagerViewController", bundle: nil)
            vc.viewModel = PlayerManagerViewModel(musics: musics, index: index)
            source.present(vc, animated: true)
        }
    }
}
