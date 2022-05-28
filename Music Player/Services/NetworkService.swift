//
//  NetworkService.swift
//  Music Player
//
//  Created by Sevak on 02.01.22.
//

import Foundation

typealias ArtistResponse = (Error?, [Artist]?) -> Void
typealias AlbumResponse = (Error?, [Album]?) -> Void
typealias TrackResponse = (Error?, [Music]?) -> Void

class NetworkService {
    func fetchArtists(completion: @escaping ArtistResponse) {
        let constant = Constants()
        let urlStr = constant.artistsURL
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode,
                  error == nil else {
                      completion(error, nil)
                      return
                  }
            do {
                let artistResult = try JSONDecoder().decode(ArtistResults.self, from: data)
                completion(nil, artistResult.artists)
            } catch {
                completion(error, nil)
            }
        }
        task.resume()
    }
    func fetchAlbums(completion: @escaping AlbumResponse) {
        let constant = Constants()
        let urlStr = constant.albumsURL
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode,
                  error == nil else {
                      completion(error, nil)
                      return
                  }
            do {
                let albumResult = try JSONDecoder().decode(AlbumResults.self, from: data)
                completion(nil, albumResult.albums)
            } catch {
                completion(error, nil)
            }
        }
        task.resume()
    }
    func fetchTracks(by trackName: String, completion: @escaping TrackResponse) {
        let constant = Constants()
        var u = constant.tracksURL + trackName
        u = u.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: u) else { return }
        let request = URLRequest(url: url)
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode,
                  error == nil else {
                      completion(error, nil)
                      return
                  }
            do {
                let trackResult = try JSONDecoder().decode(Results.self, from: data)
                completion(nil, trackResult.tracks)
            } catch {
                completion(error, nil)
            }
        }
        task.resume()
    }
}
