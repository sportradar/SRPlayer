//
//  ContentView.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 09.09.25.
//

import SwiftUI

import SRAVPlayerSDK

struct DemoSettings {
    let themeComparison: Bool
    let forcePlayerError: Bool
    let autoplay: Bool
    
    init(themeComparison: Bool, forcePlayerError: Bool, autoplay: Bool) {
        self.themeComparison = themeComparison
        self.forcePlayerError = forcePlayerError
        self.autoplay = autoplay
    }
}

//MARK: - Content View
struct ContentView: View {
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
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(.top)
                } else if customUISettings.useCustomControlContentProvider {
                    SRAVPlayerView(viewModel: viewModel, controlContentProvider: CustomControlContentProvider(useCustomControls: customUISettings.useCustomControlContentProvider))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(.top)
                } else {
                    SRAVPlayerView(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(.top)
                }
                
                if demoSettings.themeComparison {
                    SRAVPlayerView(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(.top)
                        .theme(PlayerTheme())
                }
                
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
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
            let assetConfiguration = PlaybackAssetConfiguration(enableAutoPlay: demoSettings.autoplay, playbackUiConfiguration: playbackControlsConfiguration)
            self.viewModel?.play(urlString: streamUrl, assetConfiguration: assetConfiguration)
        }
        .onDisappear {
            self.viewModel?.destroy()
        }
    }
}

// MARK: - Debug and log received.
private extension ContentView {
    private func logReceived(message: SRAVDebugLoggerModelType) {
        print("Demo received log: \(message)")
    }
}

#Preview {
    let settingsModel = SettingsModel(useCustomControlContentProvider: false,
                                      useCustomPlayerControlsLayerView: true,
                                      useCustomErrorLayerView: false,
                                      useCustomLoadingLayerView: true,
                                      useCustomCompleteLayerView: false,
                                      hideControls: false,
                                      hideSlider: false,
                                      hidePlayPauseToggle: false,
                                      hideTitle: false,
                                      hidePictureInPicture: false,
                                      hideSettingsMenu: false,
                                      hideFullscreenToggle: false,
                                      hideRemotePlayback:false)
    ContentView(settings: SRAVPlayerSettingsModel(), demoSettings: .init(themeComparison: false, forcePlayerError: false, autoplay: false), customUISettings:settingsModel, streamUrl: "")
}

