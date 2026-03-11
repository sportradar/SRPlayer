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
    private let playerViewModel: SRAVPlayerViewModel
    private let settingsModel: SettingsModel
    private let playerPositionAndSize = PlayerPositionAndSize.centerRegular
    
    private(set) lazy var hostingViewController = {
        let playerV = SRAVPlayerView(viewModel: playerViewModel)
        return UIHostingController(rootView: playerV)
    }()
    
    private(set) lazy var hostingCustomLayerViewController = {
        let playerV = SRAVPlayerView(viewModel: playerViewModel, controlContentProvider: CustomControlContentProvider(useCustomControls: settingsModel.useCustomControlContentProvider), layerProvider: CustomPlayerLayerProvider(settings: settingsModel))
        return UIHostingController(rootView: playerV)
    }()
    
    init(settings: SRAVPlayerSettingsModel, settingsModel: SettingsModel) {
        playerViewModel = SRAVPlayerViewModel(settings: settings)
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
        /* Old implementation that is not working with confirmation dialog. */
        /*
        let player = SRAVPlayer()
        let vm = SRAVPlayerViewModel(player: player, settings: playerSettings)
        
        let playerV = SRAVPlayerView(viewModel: vm)
        let hc = UIHostingController(rootView: playerV)
        videoPlayerView.addSubview(hc.view)
        hc.view.translatesAutoresizingMaskIntoConstraints = false
        hc.view.pin(to: videoPlayerView, insets: .zero)
        */
        
        if settingsModel.shouldUseCustomOverviewLayerView {
            videoPlayerView.addSubview(hostingCustomLayerViewController.view)
            
            hostingCustomLayerViewController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingCustomLayerViewController.view.pin(to: videoPlayerView, insets: .zero)
        } else {
            videoPlayerView.addSubview(hostingViewController.view)
            
            hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingViewController.view.pin(to: videoPlayerView, insets: .zero)
        }
        
        let playbackControlsConfiguration = PlaybackControlsConfiguration(controlsLayer: !settingsModel.hideControls,
                                                                          progressBar: !settingsModel.hideSlider,
                                                                          centerPlayButton: !settingsModel.hidePlayPauseToggle,
                                                                          titleText: !settingsModel.hideTitle,
                                                                          pictureInPicture: !settingsModel.hidePictureInPicture,
                                                                          settingsMenu: !settingsModel.hideSettingsMenu,
                                                                          fullscreenToggle: !settingsModel.hideFullscreenToggle,
                                                                          replayButton: true,
                                                                          remotePlayback: !settingsModel.hideRemotePlayback)
        let assetConfiguration = PlaybackAssetConfiguration(enableAutoPlay: settingsModel.autoplay, playbackUiConfiguration: playbackControlsConfiguration)
        
        playerViewModel.play(urlString: "https://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8", assetConfiguration: assetConfiguration)
    }
}
