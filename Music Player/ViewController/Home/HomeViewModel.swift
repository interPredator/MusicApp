//
//  HomeViewModel.swift
//  Music Player
//
//  Created by Sevak on 06.01.22.
//

import UIKit

enum HomeSectionType {
    case artist
    case album
    case tracks
    
    var sectionTitle: String {
        switch self {
        case .artist:
            return "Artists"
        case .album:
            return "Albums"
        case .tracks:
            return "Tracks"
        }
    }
}

class HomeViewModel {
    let networkService = NetworkService()

    private(set) var tracks: [Music] = []

    func fetchTracks(by artistName: String, completion: @escaping TrackResponse) {
        networkService.fetchTracks(by: artistName) { (error, tracks) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error, nil)
                } else if let tracks = tracks {
                    self.tracks = tracks
                    completion(nil, tracks)
                }
            }
        }
    }
}
