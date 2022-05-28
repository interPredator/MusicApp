//
//  CellInstance.swift
//  Music Player
//
//  Created by Sevak on 21.01.22.
//

import Foundation
import UIKit
protocol CellDequeueReusable { }

extension CellDequeueReusable {
    static func cell(table: UITableView, indexPath: IndexPath) -> Self {
        let cell = table.dequeueReusableCell(withIdentifier: String(describing: self), for: indexPath) as! Self
        return cell
    }
    static func cell(collection: UICollectionView, indexPath: IndexPath, reuseIdentifire: String = "") -> Self {
        let reuseIdentifire = reuseIdentifire.isEmpty ? String(describing: self) : reuseIdentifire
        let cell = collection.dequeueReusableCell(withReuseIdentifier: reuseIdentifire, for: indexPath) as! Self
        return cell
    }
}
