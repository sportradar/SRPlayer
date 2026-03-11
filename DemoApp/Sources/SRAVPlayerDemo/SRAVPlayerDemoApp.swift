//
//  SRAVPlayerDemoApp.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 09.09.25.
//

import SwiftUI

import SRAVPlayerSDK

@main
struct SRAVPlayerDemoApp: App {
    
    var body: some Scene {
        WindowGroup {
            SettingsView()
                .onAppear() {
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
