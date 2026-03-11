//
//  CustomAnalyticsProvider.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import Foundation
import SRAVPlayerSDK

final class CustomAnalyticsProvider: SRSDKPlayerAnalyticsProvider {
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
