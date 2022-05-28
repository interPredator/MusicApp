//
//  MusicManager.swift
//  Music Player
//
//  Created by Sevak on 02.01.22.
//

import Foundation

struct ArtistResults: Codable {
    let artists: [Artist]
    enum CodingKeys: String, CodingKey {
        case artists = "results"
    }
}

struct AlbumResults: Codable {
    let albums: [Album]
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}

struct Results: Codable {
    let tracks: [Music]
    enum CodingKeys: String, CodingKey {
        case tracks = "results"
    }
}

class Music: Codable {
    let trackName: String
    let artistName: String
    let collectionName: String
    let trackPrice: Double
    let country: String
    let previewUrl: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let trackId: Int
    var isFavorited = false
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try container.decode(String.self, forKey: .trackName)
        artistName = try container.decode(String.self, forKey: .artistName)
        collectionName = try container.decode(String.self, forKey: .collectionName)
        country = try container.decode(String.self, forKey: .country)
        trackPrice = try container.decode(Double.self, forKey: .trackPrice)
        previewUrl = try container.decode(String.self, forKey: .previewUrl)
        artworkUrl30 = try container.decode(String.self, forKey: .artworkUrl30)
        artworkUrl60 = try container.decode(String.self, forKey: .artworkUrl60)
        artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
        trackId = try container.decode(Int.self, forKey: .trackId)

    }
    
}

struct Artist: Codable {
    let wrapperType: String
    var artistName: String
    let artistLinkUrl: String
    let primaryGenreName: String
    
}

struct Album: Codable {
    let wrapperType: String
    let artistName: String
    let collectionName: String
    let primaryGenreName: String
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let trackCount: Int
    let copyright: String
    let releaseDate: String

}
