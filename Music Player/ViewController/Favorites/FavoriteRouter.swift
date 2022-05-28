//
//  FavoriteRouter.swift
//  Music Player
//
//  Created by Sevak on 20.01.22.
//

import Foundation

enum FavoriteCellSegue {
    case playerManager([Music], Int)
}

protocol FavoriteViewCellRoutable: Routable where SegueType == FavoriteCellSegue, SourceType == FavoritesViewController {
    
}

struct FavoriteRoutable: FavoriteViewCellRoutable {
    func perform(_ segue: FavoriteCellSegue, from source: FavoritesViewController) {
        switch segue {
        case let .playerManager(musics, index):
            let vc = PlayerManagerViewController(nibName: "PlayerManagerViewController", bundle: nil)
            vc.viewModel = PlayerManagerViewModel(musics: musics, index: index)
            source.present(vc, animated: true)
        }
    }
}

