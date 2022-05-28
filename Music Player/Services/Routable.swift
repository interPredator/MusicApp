//
//  Router.swift
//  Music Player
//
//  Created by Sevak on 17.01.22.
//

import Foundation

protocol Routable {
    associatedtype SegueType
    associatedtype SourceType
    func perform(_ segue: SegueType, from source: SourceType)
}
