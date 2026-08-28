//
//  ContentView.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 09.09.25.
//

import SwiftUI

import SRAVPlayerSDK
import SRAVPlayerNPAWPlugin
import SRAVPlayerChromecastPlugin

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

struct ContentView: ChromecastScreenView, View {
    @Environment(\.playerSDK) private var playerSDK
    @Environment(\.chromecastPlugin) private var chromecastPlugin

    @StateObject private var viewModel: ContentViewModel

    init(
        orientationConfiguration: PlayerOrientationConfiguration,
        demoSettings: DemoSettings,
        customUISettings: SettingsModel,
        streamSource: DemoStreamOption
    ) {
        _viewModel = StateObject(
            wrappedValue: ContentViewModel(
                orientationConfiguration: orientationConfiguration,
                demoSettings: demoSettings,
                customUISettings: customUISettings,
                streamSource: streamSource
            )
        )
    }

    var body: some View {
        VStack {
            if let sessionHandler = viewModel.sessionHandler {
                if viewModel.customUISettings.shouldUseCustomOverviewLayerView {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            overlays: CustomPlayerViewOverlays(
                                settings: viewModel.customUISettings,
                                playerControls: viewModel.playerControls,
                                onClose: {
                                    viewModel.closePlayer()
                                }
                            ),
                            actionConfiguration: PlayerActionConfiguration(
                                onEndScreenItem: { item in
                                    viewModel.playEndScreenItem(item)
                                }
                            ),
                            streamingStatusRestrictedAccessConfiguration: viewModel.restrictedAccessConfiguration,
                            orientationConfiguration: viewModel.orientationConfiguration
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .aspectRatio(16/9, contentMode: .fit)
                    .padding(.top)
                } else if viewModel.customUISettings.useCustomPlayerControls {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            playerControls: viewModel.playerControls,
                            orientationConfiguration: viewModel.orientationConfiguration
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .aspectRatio(16/9, contentMode: .fit)
                    .padding(.top)
                } else {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            orientationConfiguration: viewModel.orientationConfiguration
                        )
                    )
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(.top)
                }

                if viewModel.demoSettings.themeComparison {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            theme: PlayerTheme(),
                            orientationConfiguration: viewModel.orientationConfiguration
                        )
                    )
                        .frame(maxWidth: .infinity)
                        .aspectRatio(16/9, contentMode: .fit)
                        .padding(.top)
                }
                
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            if let chromecastPlugin {
                ToolbarItem(placement: .navigationBarTrailing) {
                    getCastButton(plugin: chromecastPlugin)
                }
            }
        }
        .presentCastMiniControllerWithConfig(screen: self, plugin: chromecastPlugin)
        .presentCastDialogWithConfig(screen: self, plugin: chromecastPlugin)
        .presentCastExpandedControllerWithConfig(screen: self, plugin: chromecastPlugin)
        .sheet(item: $viewModel.restrictedAccessSheet) { sheet in
            RestrictedAccessBottomSheet(sheet: sheet)
        }
        .onAppear {
            viewModel.onAppear(playerSDK: playerSDK)
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

#Preview {
    let settingsModel = SettingsModel(useCustomPlayerControls: false,
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
    ContentView(orientationConfiguration: .default, demoSettings: .init(themeComparison: false, forcePlayerError: false, autoplay: false), customUISettings:settingsModel, streamSource: StreamSource.defaultStream)
}
