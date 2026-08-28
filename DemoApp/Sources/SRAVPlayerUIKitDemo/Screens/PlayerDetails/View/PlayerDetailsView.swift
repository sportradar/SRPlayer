//
//  PlayerDetailsView.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 14. 10. 25.
//

import UIKit
import SwiftUI

import SRAVPlayerSDK

final class PlayerDetailsView: UIView {
    private let videoPlayerView = UIView()
    private let settingsModel: SettingsModel
    private let orientationConfiguration: PlayerOrientationConfiguration
    private let playerPositionAndSize = PlayerPositionAndSize.centerRegular
    private var sessionHandler: SRAVSessionHandler?
    private(set) var hostingViewController: UIHostingController<AnyView>?
    var onClose: @MainActor () -> Void = {}
    /// Invoked whenever the SwiftUI hosting controller is created or cleared so the parent can `addChild` / `removeFromParent`.
    var onHostingControllerChanged: ((UIHostingController<AnyView>?) -> Void)?

    init(orientationConfiguration: PlayerOrientationConfiguration, settingsModel: SettingsModel) {
        self.orientationConfiguration = orientationConfiguration
        self.settingsModel = settingsModel
        super.init(frame: .zero)
        setup()
        setupVideoPlayerView()
        startVideoPlayer()
    }
    
    private enum PlayerPositionAndSize { case centerRegular, centerSmall, topLeadingSmall, topTrailingSmall, bottomLeadingSmall, bottomTrailingSmall }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .magenta
    }
    
    private func setupVideoPlayerView() {
        addSubview(videoPlayerView)
        
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        videoPlayerView.clipsToBounds = true
        
        /* Different view player demo positions.*/
        switch playerPositionAndSize {
        case .centerRegular:
            /* Center - regular player view size. */
            videoPlayerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            videoPlayerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            videoPlayerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            videoPlayerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        case .centerSmall:
            /* Center - very small player view size */
            videoPlayerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            videoPlayerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            videoPlayerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            videoPlayerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        case .topLeadingSmall:
            /* Top leading - very small player view size */
            videoPlayerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            videoPlayerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            videoPlayerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            videoPlayerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        case .topTrailingSmall:
            /* Top trailing - very small player view size */
            videoPlayerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            videoPlayerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            videoPlayerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            videoPlayerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        case .bottomLeadingSmall:
            /* Bottom leading - very small player view size */
            videoPlayerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            videoPlayerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            videoPlayerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            videoPlayerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        case .bottomTrailingSmall:
            /* Bottom trailing - very small player view size */
            videoPlayerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            videoPlayerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            videoPlayerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            videoPlayerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }

    private func startVideoPlayer() {
        createSession()
    }
    
    private func createSession() {
        // Stream swap: force teardown (no PiP skip) before creating a new session.
        sessionHandler?.destroy()
        detachHostingController()
        sessionHandler = nil

        let urlString = "https://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8"
        switch PlayerService.sdk.createSession(input: urlString) {
        case .success(let handler):
            let playbackControlsConfiguration = PlaybackControlsConfiguration(controlsLayer: !settingsModel.hideControls,
                                                                              progressBar: !settingsModel.hideSlider,
                                                                              centerPlayButton: !settingsModel.hidePlayPauseToggle,
                                                                              titleText: !settingsModel.hideTitle,
                                                                              pictureInPicture: !settingsModel.hidePictureInPicture,
                                                                              settingsMenu: !settingsModel.hideSettingsMenu,
                                                                              fullscreenToggle: !settingsModel.hideFullscreenToggle,
                                                                              remotePlayback: !settingsModel.hideRemotePlayback,
                                                                              seek:true,
                                                                              rewind: true,
                                                                              seekButtonDistanceInMS: 1000,
                                                                              showPipProgressBar: true)
            let playbackOptions = PlaybackOptions(enableAutoPlay: settingsModel.autoplay, startFromLive: false, startPositionVod: 0)
            let assetConfiguration = PlaybackAssetConfiguration(playbackOptions: playbackOptions,
                                                                playbackUiConfiguration: playbackControlsConfiguration)
            
            handler.session.load(settings: CustomPlayerSettings.default, assetConfiguration: assetConfiguration)
            self.sessionHandler = handler
            embedPlayerView(sessionHandler: handler)
            
        case .failure:
            break
        }
    }

    /// Tears down the session unless PiP is active (`allowPictureInPicture: true`).
    /// When destroy returns `false`, keeps the handler and hosting UI so PiP can continue.
    func destroySession() {
        guard sessionHandler?.destroy(allowPictureInPicture: true) == true else { return }
        sessionHandler = nil
        detachHostingController()
    }

    private func detachHostingController() {
        guard let hosting = hostingViewController else { return }
        hosting.willMove(toParent: nil)
        hosting.view.removeFromSuperview()
        hosting.removeFromParent()
        hostingViewController = nil
        onHostingControllerChanged?(nil)
    }

    private func embedPlayerView(sessionHandler: SRAVSessionHandler) {
        detachHostingController()

        // SRAVPlayerView is generic over Overlays, so the custom and default
        // builders return different concrete types. AnyView erases that difference so
        // both can share one UIHostingController<AnyView>.
        let rootView: AnyView
        if settingsModel.shouldUseCustomOverviewLayerView {
            rootView = AnyView(buildPlayerViewWithCustomPlayerLayer(sessionHandler: sessionHandler))
        } else {
            rootView = AnyView(buildPlayerViewDefault(sessionHandler: sessionHandler))
        }

        let hosting = UIHostingController(rootView: rootView)
        hostingViewController = hosting
        videoPlayerView.addSubview(hosting.view)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.pin(to: videoPlayerView, insets: .zero)
        onHostingControllerChanged?(hosting)
    }

    /// Custom overlays: `CustomPlayerViewOverlays` (+ optional custom player controls).
    private func buildPlayerViewWithCustomPlayerLayer(sessionHandler: SRAVSessionHandler) -> some View {
        SRAVPlayerView(
            sessionHandler: sessionHandler,
            configuration: PlayerViewConfiguration(
                overlays: CustomPlayerViewOverlays(
                    settings: settingsModel,
                    playerControls: CustomPlayerControls(
                        useCustomControls: settingsModel.useCustomPlayerControls
                    ),
                    onClose: {
                        sessionHandler.closePlayer()
                    }
                ),
                actionConfiguration: PlayerActionConfiguration(
                    onClose: { [weak self] in
                        self?.onClose()
                    },
                    autoDismiss: false
                ),
                orientationConfiguration: orientationConfiguration
            )
        )
    }

    /// Default overlays: `PlayerViewConfiguration` → `DefaultConfiguredPlayerViewOverlays`.
    private func buildPlayerViewDefault(sessionHandler: SRAVSessionHandler) -> some View {
        SRAVPlayerView(
            sessionHandler: sessionHandler,
            configuration: PlayerViewConfiguration(
                actionConfiguration: PlayerActionConfiguration(
                    onClose: { [weak self] in
                        self?.onClose()
                    },
                    autoDismiss: false
                ),
                orientationConfiguration: orientationConfiguration
            )
        )
    }
}
