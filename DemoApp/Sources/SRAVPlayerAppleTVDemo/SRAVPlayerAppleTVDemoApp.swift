//
//  SRAVPlayerAppleTVDemoApp.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 18. 12. 25.
//

import SwiftUI
import AVPlayerDataSDK

@main
struct SRAVPlayerAppleTVDemoApp: App {
    var body: some Scene {
        WindowGroup {
            SettingsView()
                .onAppear() {
                    Task {
                        let customAnalyticsProvider = CustomAnalyticsProvider()
                        let loggingConfiguration = LoggerConfiguration(minLogLevel: .verbose)
                        
                        SRAVPlayer.Builder()
                            .setClientId(clientId: 123)
                            .setLicenseKey(licenseKey: "ag.sportradar.Demo")
                            .setLoggerProvider(loggerConfiguration: loggingConfiguration)
                            .setAnalyticsProvider(analyticsProvider: customAnalyticsProvider)
                            .buildSRAVPlayerSdk()
                    }

                }
        }
    }
}
