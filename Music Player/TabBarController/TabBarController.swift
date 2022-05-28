//
//  TabBarController.swift
//  Music Player
//
//  Created by Sevak on 28.12.21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let tabBar = UITabBarController()
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesViewController()
        let viewControllers = [homeVC, searchVC, favoritesVC]
        tabBar.viewControllers = viewControllers
    }
}

