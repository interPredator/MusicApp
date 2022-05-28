//
//  SearchViewModel.swift
//  Music Player
//
//  Created by Sevak on 20.01.22.
//

import Foundation

class SearchViewModel {
    let networkService = NetworkService()

    private(set) var searchedTracks: [Music] = []

    func fetchTracks(by trackName: String, completion: @escaping TrackResponse) {
        networkService.fetchTracks(by: trackName) { (error, tracks) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error, nil)
                } else if let tracks = tracks {
                    self.searchedTracks = tracks
                    completion(nil, tracks)
                }
            }
        }
    }
}
