//
//  CustomAnalyticsProvider.swift
//  SRAVPlayerDemo
//
//  Created by Boris Filipovic on 2. 12. 25.
//

import Foundation
import AVKit

import SRAVPlayerSDK

nonisolated
final class CustomAnalyticsProvider: PlayerAnalyticsProvider {
    func attachPlayer(player: any NativePlayer) {
        guard let nativePlayer = player as? AVPlayer else { return }
        print("Native Player \(nativePlayer)")
    }
    
    func detachMediaSession() {
        //TODO: implement
    }
    
    func detachPlayer() {
        //TODO: implement
    }
    
    func onCastApplicationConnected() {
        //TODO: implement
    }
    
    func onCastApplicationDisconnected() {
        //TODO: implement
    }
    
    func trackError(error: any SRAVPlayerException, metadata: [String : Any]) {
        /* Client handles this event. */
        print("CustomAnalyticsProvider received trackError event. error \(error), metaddata: \(metadata)")
    }
    
    func trackStreamEvent(event: StreamEvent, metadata: [String : Any]) {
        /* Client handles this event. */
        print("CustomAnalyticsProvider received trackStreamEvent event. event \(event), metaddata: \(metadata)")
    }
    
    func trackUserAction(action: UserAction, metadata: [String : Any]) {
        /* Client handles this event. */
        print("CustomAnalyticsProvider received trackUserAction event. action \(action), metaddata: \(metadata)")
    }
}
