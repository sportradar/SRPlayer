//
//  SRAVPlayerDemoApp.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 09.09.25.
//

import SwiftUI

import SRAVPlayerSDK
import SRAVPlayerChromecastPlugin

@main
struct SRAVPlayerDemoApp: App {
    private let playerSDK : SRAVPlayer
    private let chromecastPlugin : ChromecastPlugin
    
    init () {
        chromecastPlugin = ChromecastPlugin(receiverAppID: DemoSecrets.chromecastReceiverAppID)
        
        playerSDK = SRAVPlayer.Builder()
            .setLicenseKey("YOUR_LICENSE_KEY")
            .setClientId(12345)
            .setLocalization("de-DE")
            //.setAnalyticsProvider(DemoAnalyticsProvider())
            .setLoggerConfiguration(LoggerConfiguration(minLogLevel: .info))
            .setModule(DirectModuleFactory())
            .setCastPlugin(chromecastPlugin)
            .build()
    }
    
    var body: some Scene {
        WindowGroup {
            SettingsView()
                .environment(\.playerSDK, playerSDK)
                .environment(\.chromecastPlugin, chromecastPlugin)
        }
    }
}
