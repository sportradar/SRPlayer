//
//  ContentViewModel.swift
//  SRAVPlayerDemo
//

import Foundation
import SRAVPlayerSDK

@MainActor
final class ContentViewModel: ObservableObject {
    let orientationConfiguration: PlayerOrientationConfiguration
    let demoSettings: DemoSettings
    let customUISettings: SettingsModel
    let streamSource: DemoStreamOption

    @Published var sessionHandler: SRAVSessionHandler?
    @Published var restrictedAccessSheet: RestrictedAccessSheet?

    private var playerSDK: SRAVPlayer?

    init(
        orientationConfiguration: PlayerOrientationConfiguration,
        demoSettings: DemoSettings,
        customUISettings: SettingsModel,
        streamSource: DemoStreamOption
    ) {
        self.orientationConfiguration = orientationConfiguration
        self.demoSettings = demoSettings
        self.customUISettings = customUISettings
        self.streamSource = streamSource
    }

    func onAppear(playerSDK: SRAVPlayer) {
        self.playerSDK = playerSDK
        createSession()
    }

    func onDisappear() {
        // Keep the session alive so PiP can continue after the screen disappears.
        // Use `sessionHandler?.destroy(allowPictureInPicture: true)` when leaving for good.
        sessionHandler?.session.pause()
    }

    func playEndScreenItem(_ item: EndScreenRelatedDataItem) {
        let input = item.link.isEmpty ? streamSource.url : item.link
        createSession(input: input, preferOTT: streamSource.isOTT)
    }

    func closePlayer() {
        sessionHandler?.closePlayer()
    }

    func showRestrictedAccessSheet(_ sheet: RestrictedAccessSheet) {
        restrictedAccessSheet = sheet
    }

    // MARK: - Player configuration

    var playerControls: CustomPlayerControls {
        CustomPlayerControls(
            useCustomControls: customUISettings.useCustomPlayerControls
        )
    }

    var restrictedAccessConfiguration: StreamingStatusRestrictedAccessConfiguration {
        StreamingStatusRestrictedAccessConfiguration(
            onSubscribe: { [weak self] in
                Task { @MainActor in
                    self?.showRestrictedAccessSheet(.register)
                }
            },
            onLogin: { [weak self] in
                Task { @MainActor in
                    self?.showRestrictedAccessSheet(.login)
                }
            }
        )
    }

    // MARK: - Session

    private func createSession() {
        let input = demoSettings.forcePlayerError
            ? "https://example.com/video.mp4"
            : streamSource.url
        createSession(input: input, preferOTT: streamSource.isOTT)
    }

    private func createSession(input: String, preferOTT: Bool) {
        guard let playerSDK else { return }

        sessionHandler?.destroy()
        sessionHandler = nil

        let moduleFactory: (any PlayerModuleFactory)? =
            (!demoSettings.forcePlayerError && preferOTT)
            ? OTTModuleFactory(
                configAdaption: OTTConfigAdaption(),
                streamAccessUseCase: OTTTokenHeaderUseCase()
            )
            : nil

        let result = playerSDK.createSession(
            input: input,
            moduleFactory: moduleFactory
        )

        switch result {
        case .success(let handler):
            attachSession(handler)
        case .failure:
            sessionHandler = nil
        }
    }

    private func attachSession(_ handler: SRAVSessionHandler) {
        let playbackControlsConfiguration = PlaybackControlsConfiguration(
            controlsLayer: !customUISettings.hideControls,
            progressBar: !customUISettings.hideSlider,
            centerPlayButton: !customUISettings.hidePlayPauseToggle,
            titleText: !customUISettings.hideTitle,
            pictureInPicture: !customUISettings.hidePictureInPicture,
            settingsMenu: !customUISettings.hideSettingsMenu,
            fullscreenToggle: !customUISettings.hideFullscreenToggle,
            remotePlayback: !customUISettings.hideRemotePlayback,
            seek: true,
            rewind: true,
            seekButtonDistanceInMS: 10000,
            showPipProgressBar: true
        )

        let playbackOptions = PlaybackOptions(
            enableAutoPlay: demoSettings.autoplay,
            startFromLive: false,
            startPositionVod: 0
        )
        let assetConfiguration = PlaybackAssetConfiguration(
            playbackOptions: playbackOptions,
            playbackUiConfiguration: playbackControlsConfiguration
        )

        handler.session.load(settings: CustomPlayerSettings.default, assetConfiguration: assetConfiguration)
        sessionHandler = handler
    }
}
