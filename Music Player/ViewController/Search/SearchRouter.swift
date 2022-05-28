//
//  SearchRouter.swift
//  Music Player
//
//  Created by Sevak on 20.01.22.
//

import Foundation

enum SearchCellSegue {
    case playerManager([Music], Int)
}

protocol SearchViewCellRoutable: Routable where SegueType == SearchCellSegue, SourceType == SearchViewController {
    
}

struct SearchRoutable: SearchViewCellRoutable {
    func perform(_ segue: SearchCellSegue, from source: SearchViewController) {
        switch segue {
        case let .playerManager(musics, index):
            let vc = PlayerManagerViewController(nibName: "PlayerManagerViewController", bundle: nil)
            vc.viewModel = PlayerManagerViewModel(musics: musics, index: index)
            source.present(vc, animated: true)
        }
    }
}
