//
//  FavoritesViewController.swift
//  Music Player
//
//  Created by Sevak on 28.12.21.
//

import UIKit
import AVFoundation
class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    let viewModel = FavoritesViewModel()
    let router = FavoriteRoutable()
    var music: Music!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter()

        setup()
        setupNavigationBar()
    }
    
    private func setup() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        FavoritesViewCell.register(collection: favoritesCollectionView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .label
        
    }
    
    func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(favorited), name: NSNotification.Name("Favorited"), object: music)
        NotificationCenter.default.addObserver(self, selector: #selector(unfavorited), name: NSNotification.Name("Unfavorited"), object: music)
        NotificationCenter.default.addObserver(self, selector: #selector(unfavorited), name: NSNotification.Name("UnfavoriteTrack"), object: music)
    }
    
    @objc func favorited(_ notification: Notification) {
        if let obj = notification.object as? Music {
            viewModel.favoriteMusics.append(obj)
            favoritesCollectionView.reloadData()
        }
    }
    
    @objc func unfavorited(_ notification: Notification) {
        if let obj = notification.object as? Music {
            viewModel.favoriteMusics = viewModel.favoriteMusics.filter { $0.trackId != obj.trackId }
            favoritesCollectionView.reloadData()
        }
    }
}
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoriteMusics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FavoritesViewCell.cell(collection: collectionView, indexPath: indexPath)
        let music = viewModel.favoriteMusics[indexPath.item]
        cell.configure(with: music)
        cell.favoriteUnfavoriteMode = .favorited
        cell.music = music
        return cell
    }
    
}
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.perform(.playerManager(viewModel.favoriteMusics, indexPath.item), from: self)
    }
}
