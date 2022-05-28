//
//  AlbumCell.swift
//  Music Player
//
//  Created by Sevak on 16.01.22.
//

import UIKit
import SDWebImage
import MarqueeLabel

class AlbumCell: CollectionViewCell {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!

    var viewModel: AlbumCellViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        register()
    }
    
    func register() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(UINib(nibName: "HorizontalCell",
                                                bundle: nil),
                                                forCellWithReuseIdentifier: "HorizontalCell")
        
    }
    func configureAlbums(with viewModel: AlbumCellViewModel) {
        self.viewModel = viewModel
        if viewModel.albums.isEmpty {
            viewModel.fetchAlbums() { [weak self] error, albums in
                self?.horizontalCollectionView.reloadData()
            }
        }
        horizontalCollectionView.reloadData()
    }
}

extension AlbumCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
        let album = viewModel.albums[indexPath.item]
            cell.configureAlbum(with: album)
            return cell

    }
}

extension AlbumCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
