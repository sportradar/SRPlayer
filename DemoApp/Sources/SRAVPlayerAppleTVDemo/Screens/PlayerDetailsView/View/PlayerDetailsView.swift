//
//  PlayerDetailsView.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct PlayerDetailsView: View {
    @State private var viewModel: SRAVPlayerViewModel?
    let settings: SRAVPlayerSettingsModel
    let demoSettings: DemoSettings
    let customUISettings: SettingsModel
    let streamUrl: String
    
    var body: some View {
        VStack {
            if let viewModel = viewModel {
                if customUISettings.shouldUseCustomOverviewLayerView {
                    SRAVPlayerView(viewModel: viewModel, controlContentProvider: CustomControlContentProvider(useCustomControls: customUISettings.useCustomControlContentProvider), layerProvider: CustomPlayerLayerProvider(settings: customUISettings))
                } else if customUISettings.useCustomControlContentProvider {
                    SRAVPlayerView(viewModel: viewModel, controlContentProvider: CustomControlContentProvider(useCustomControls: customUISettings.useCustomControlContentProvider))
                } else {
                    SRAVPlayerView(viewModel: viewModel)
                }
            }
        }
        .onAppear {

            let debugConfiguration = SRAVDebugLoggerConfiguration(isEnabled: true, customLogger: logReceived)
            let viewModel = SRAVPlayerViewModel(settings: settings, debugLoggingConfiguration: debugConfiguration)
            self.viewModel = viewModel
            
            let playbackControlsConfiguration = PlaybackControlsConfiguration(controlsLayer: !customUISettings.hideControls,
                                                                              progressBar: !customUISettings.hideSlider,
                                                                              centerPlayButton: !customUISettings.hidePlayPauseToggle,
                                                                              titleText: !customUISettings.hideTitle,
                                                                              pictureInPicture: !customUISettings.hidePictureInPicture,
                                                                              settingsMenu: !customUISettings.hideSettingsMenu,
                                                                              fullscreenToggle: !customUISettings.hideFullscreenToggle,
                                                                              replayButton: true,
                                                                              remotePlayback: !customUISettings.hideRemotePlayback)
            let assetConfig = PlaybackAssetConfiguration(enableAutoPlay: demoSettings.autoplay, playbackUiConfiguration: playbackControlsConfiguration)
            self.viewModel?.play(urlString: streamUrl, assetConfiguration: assetConfig)
        }
        .onDisappear {
            self.viewModel?.destroy()
        }
    }
}

// MARK: - Debug and log received.
private extension PlayerDetailsView {
    private func logReceived(message: SRAVDebugLoggerModelType) {
        print("Demo received log: \(message)")
    }
}
