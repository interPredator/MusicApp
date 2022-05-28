//
//  SearchViewController.swift
//  Music Player
//
//  Created by Sevak on 28.12.21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = SearchViewModel()
    let router = SearchRoutable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.textColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func register() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = .label
        SearchCell.register(collection: searchCollectionView)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.searchedTracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SearchCell.cell(collection: collectionView, indexPath: indexPath)
        let searchedTrack = viewModel.searchedTracks[indexPath.item]
        cell.configure(with: searchedTrack)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.perform(.playerManager(viewModel.searchedTracks, indexPath.item), from: self)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCollectionView.reloadData()
        viewModel.fetchTracks(by: searchText) { [weak self] (error, musics) in
            if let error = error {
                print(error)
            } else {
                self?.searchCollectionView.reloadData()
            }
        }
    }
}
