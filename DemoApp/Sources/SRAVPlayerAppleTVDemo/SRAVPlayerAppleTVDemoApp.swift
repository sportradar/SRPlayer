//
//  SRAVPlayerAppleTVDemoApp.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 18. 12. 25.
//

import SwiftUI
import SRAVPlayerSDK

@main
struct SRAVPlayerAppleTVDemoApp: App {
    private let playerSDK : SRAVPlayer
    
    init () {
        playerSDK = SRAVPlayer.Builder()
            .setLicenseKey("YOUR_LICENSE_KEY")
            .setClientId(12345)
            .setLocalization("de-DE")
            //.setAnalyticsProvider(DemoAnalyticsProvider())
            .setLoggerConfiguration(LoggerConfiguration(minLogLevel: .debug))
            .setModule(DirectModuleFactory())
            .build()
    }
    
    var body: some Scene {
        WindowGroup {
            SettingsView()
                .environment(\.playerSDK, playerSDK)
        }
    }
}
