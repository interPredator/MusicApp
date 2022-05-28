//
//  PlayerManagerRouter.swift
//  Music Player
//
//  Created by Sevak on 21.01.22.
//

import Foundation
import UIKit

enum PlayerManagerSegue {
    
}

protocol PlayerManagerRoutable: Routable where SegueType == PlayerManagerSegue, SourceType == PlayerManagerViewController {
    
}

struct PlayerManagerRouter: PlayerManagerRoutable {
    func perform(_ segue: PlayerManagerSegue, from source: PlayerManagerViewController) {
     
    }
}
