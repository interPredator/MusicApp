//
//  ViewController.swift
//  Music Player
//
//  Created by Sevak on 06.01.22.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nc = viewControllers?[2] as? UINavigationController, let vc = nc.viewControllers.first as? FavoritesViewController {
            _ = vc.view
        }
        
    }
    


}
