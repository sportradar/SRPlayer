//
//  CustomAnalyticsProvider.swift
//  SRAVPlayerDemo
//
//  Created by Boris Filipovic on 2. 12. 25.
//

import Foundation
import SRAVPlayerSDK

final class CustomAnalyticsProvider: PlayerAnalyticsProvider {
    func trackError(error: PlaybackError, metadata: [String : Any]) {
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
