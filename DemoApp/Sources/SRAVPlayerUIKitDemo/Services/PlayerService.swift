//
//  PlayerService.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Andreas Becher on 23.03.26.
//

import SRAVPlayerSDK

class PlayerService {
    @MainActor
    static let instance = PlayerService()
    
    private(set) var playerSDK: SRAVPlayer!
    
    private init() {}
    
    static var sdk: SRAVPlayer {
        instance.playerSDK
    }
    
    func bind(playerSDK : SRAVPlayer) {
        self.playerSDK = playerSDK
    }
}

