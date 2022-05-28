//
//  TrackCellViewModel.swift
//  Music Player
//
//  Created by Sevak on 17.01.22.
//

import Foundation

class TrackCellViewModel {
    
    let networkService = NetworkService()
    
    private(set) var albums: [Album] = []
    
    func fetchAlbums(by artistName: String, completion: @escaping AlbumResponse) {
        networkService.fetchAlbums() { (error, albums) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error, nil)
                } else if let albums = albums {
                    self.albums = albums
                    completion(nil, albums)
                }
            }
        }
    }
}
