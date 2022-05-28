//
//  File.swift
//  Music Player
//
//  Created by Sevak on 16.01.22.
//

import Foundation

class ArtistCellViewModel {
    
    let networkService = NetworkService()
    
    private(set) var artists: [Artist] = []
    
    func fetchArtists(completion: @escaping ArtistResponse) {
        networkService.fetchArtists() { (error, artists) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error, nil)
                } else if let artists = artists {
                    self.artists = artists
                    completion(nil, artists)
                }
            }
        }
    }
}
