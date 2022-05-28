//
//  HorizontalCell.swift
//  Music Player
//
//  Created by Sevak on 08.01.22.
//

import UIKit

protocol ArtistCellDelegate: AnyObject {
    func artistCell(_ cell: ArtistCell, didSelect item: Artist)
}


class ArtistCell: CollectionViewCell {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    var viewModel: ArtistCellViewModel!
    weak var delegate: ArtistCellDelegate?
    
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
    func configureArtists(with viewModel: ArtistCellViewModel) {
        self.viewModel = viewModel
        if viewModel.artists.isEmpty {
            viewModel.fetchArtists() { [weak self] error, albums in
                self?.horizontalCollectionView.reloadData()
            }
        }
        horizontalCollectionView.reloadData()
    }
}

extension ArtistCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
        let artist = viewModel.artists[indexPath.item]
        cell.configureArtist(with: artist)
        return cell
    }
}

extension ArtistCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artist = viewModel.artists[indexPath.item]
        delegate?.artistCell(self, didSelect: artist)
    }
}
