//
//  StoryboardInstance.swift
//  Music Player
//
//  Created by Sevak on 21.01.22.
//

import Foundation
import UIKit

protocol StoryboardInstance {
    static var storyboardName: StoryboardName { get set }
}

extension StoryboardInstance {
    static var storyboardInstance: Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
        return viewController
    }
}
