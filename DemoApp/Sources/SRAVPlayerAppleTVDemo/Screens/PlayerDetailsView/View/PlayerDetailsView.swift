//
//  PlayerDetailsView.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct PlayerDetailsView: View {
    @Environment(\.playerSDK) private var playerSDK

    let orientationConfiguration: PlayerOrientationConfiguration
    let demoSettings: DemoSettings
    let customUISettings: SettingsModel
    let streamUrl: String
    
    @State private var sessionHandler: SRAVSessionHandler?

    private var actionConfiguration: PlayerActionConfiguration {
        // Default autoDismiss: true — SwiftUI dismiss() after close / Menu.
        PlayerActionConfiguration()
    }
    
    var body: some View {
        VStack {
            if let sessionHandler {
                if customUISettings.shouldUseCustomOverviewLayerView {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            overlays: CustomPlayerViewOverlays(
                                settings: customUISettings,
                                playerControls: CustomPlayerControls(
                                    useCustomControls: customUISettings.useCustomPlayerControls
                                ),
                                onClose: { sessionHandler.closePlayer() }
                            ),
                            actionConfiguration: actionConfiguration,
                            orientationConfiguration: orientationConfiguration
                        )
                    )
                } else if customUISettings.useCustomPlayerControls {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            playerControls: CustomPlayerControls(
                                useCustomControls: customUISettings.useCustomPlayerControls
                            ),
                            actionConfiguration: actionConfiguration,
                            orientationConfiguration: orientationConfiguration
                        )
                    )
                } else {
                    SRAVPlayerView(
                        sessionHandler: sessionHandler,
                        configuration: PlayerViewConfiguration(
                            actionConfiguration: actionConfiguration,
                            orientationConfiguration: orientationConfiguration
                        )
                    )
                }
            }
        }
        .onAppear {
            createSession()
        }
        .onDisappear {
            cancelCurrentSession()
        }
    }
    
    //MARK: Session creation
    private func createSession() {
        sessionHandler?.destroy()
        sessionHandler = nil

        switch playerSDK.createSession(input: streamUrl) {
        case .success(let handler):
            let playbackControlsConfiguration = PlaybackControlsConfiguration(controlsLayer: !customUISettings.hideControls,
                                                                              progressBar: !customUISettings.hideSlider,
                                                                              centerPlayButton: !customUISettings.hidePlayPauseToggle,
                                                                              titleText: !customUISettings.hideTitle,
                                                                              pictureInPicture: !customUISettings.hidePictureInPicture,
                                                                              settingsMenu: !customUISettings.hideSettingsMenu,
                                                                              fullscreenToggle: !customUISettings.hideFullscreenToggle,
                                                                              remotePlayback: !customUISettings.hideRemotePlayback,
                                                                              seek:true,
                                                                              rewind: true,
                                                                              seekButtonDistanceInMS: 1000,
                                                                              showPipProgressBar: true)
            

            let playbackOptions = PlaybackOptions(enableAutoPlay: demoSettings.autoplay, startFromLive: false, startPositionVod: 0)
            let assetConfiguration = PlaybackAssetConfiguration(playbackOptions: playbackOptions, playbackUiConfiguration: playbackControlsConfiguration)
         
            handler.session.load(settings: CustomPlayerSettings.default, assetConfiguration: assetConfiguration)
            self.sessionHandler = handler
        case .failure:
            self.sessionHandler = nil
        }
    }
    
    private func cancelCurrentSession() {
        sessionHandler?.destroy()
        sessionHandler = nil
    }
}
