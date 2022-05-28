//
//  CellRegistable.swift
//  Music Player
//
//  Created by Sevak on 21.01.22.
//

import Foundation
import UIKit

protocol CellRegistable: CellDequeueReusable { }

extension CellRegistable {
    static func register(table: UITableView) {
        table.register(UINib(nibName: String(describing: self), bundle: nil), forCellReuseIdentifier: String(describing: self))
    }
    static func register(collection: UICollectionView) {
        collection.register(UINib(nibName: String(describing: self), bundle: nil), forCellWithReuseIdentifier: String(describing: self))
    }
}
