//
//  HomeViewController.swift
//  Music Player
//
//  Created by Sevak on 28.12.21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    private var timer: Timer?
    var viewModel = HomeViewModel()
    var router = HomeRouter()
    var sections: [HomeSectionType] = [.artist, .album, .tracks]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        configure()
    }
    
    func configure() {
        navigationController?.navigationBar.barTintColor = .label
    }
    
    private func register() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        AlbumCell.register(collection: homeCollectionView)
        ArtistCell.register(collection: homeCollectionView)
        TrackCell.register(collection: homeCollectionView)
        AlbumCell.register(collection: homeCollectionView)
        
        homeCollectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        viewModel.fetchTracks(by: "Adele") { [weak self] (error, musics) in
            if let error = error {
                print(error)
            } else {
                self?.homeCollectionView.reloadData()
            }
        }
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .artist:
            return 1
        case .album:
            return 1
        case .tracks:
            return viewModel.tracks.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .artist:
            let cell = ArtistCell.cell(collection: collectionView, indexPath: indexPath)
            let vm = ArtistCellViewModel()
            cell.configureArtists(with: vm)
            cell.delegate = self
            return cell
        case .album:
            let cell = AlbumCell.cell(collection: collectionView, indexPath: indexPath)
            let vm = AlbumCellViewModel()
            cell.configureAlbums(with: vm)
            return cell
        case .tracks:
            let cell = TrackCell.cell(collection: collectionView, indexPath: indexPath)
            let music = viewModel.tracks[indexPath.item]
            cell.configure(with: music)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            header.configure(with: sections[indexPath.section])
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = sections[indexPath.section]
        switch type {
        case .artist:
            return CGSize(width: collectionView.bounds.width, height: 80)
        case .album:
            return CGSize(width: collectionView.bounds.width, height: 150)
        case .tracks:
            return CGSize(width: (collectionView.bounds.width / 3) - 15 , height: (collectionView.bounds.width / 3) + 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = sections[indexPath.section]
        switch type {
        case .artist:
            return
        case .album:
            return
        case .tracks:
            router.perform(.playerManager(viewModel.tracks, indexPath.item), from: self)

        }
    }
}

extension HomeViewController: ArtistCellDelegate {
    func artistCell(_ cell: ArtistCell, didSelect item: Artist) {
        router.perform(.artistDetail(item), from: self)
    }
}
