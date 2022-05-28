//
//  PlayerManager.swift
//  Music Player
//
//  Created by Sevak on 04.01.22.
//

import Foundation
import AVFoundation

class PlayerManagerViewModel {
    
    // MARK: - Properties
//    var shuffle: ShuffleMode!
    var music: Music!
    var musics: [Music] = []
    var index: Int!
    var playerManager: PlayerManager?
    
    // MARK: - Initialization
    init(musics: [Music], index: Int) {
        self.musics = musics
        self.index = index
        self.music = musics[index]
        self.playerManager = PlayerManager(music: music)
    }
 
    func previous() {
        if index == 0 { return }
        index -= 1
        music = musics[index]
        playerManager = PlayerManager(music: music)
        
    }
    func next() {
        if index == musics.count - 1 { return }
        index += 1
        music = musics[index]
        playerManager = PlayerManager(music: music)
    }
    func shuffle() {
        music = musics.randomElement()
        playerManager = PlayerManager(music: music)
    }
    func repeatListNext() {

        if index == musics.count - 1 {
            index = 0
            music = musics[index]
            playerManager = PlayerManager(music: music)
        } else {
        index += 1
        music = musics[index]
        playerManager = PlayerManager(music: music)
        }
    }
    func repeatListPrevious() {

        if index == 0 {
            index = musics.count - 1
            music = musics[index]
            playerManager = PlayerManager(music: music)
        } else {
        index -= 1
        music = musics[index]
        playerManager = PlayerManager(music: music)
        }
    }
}


