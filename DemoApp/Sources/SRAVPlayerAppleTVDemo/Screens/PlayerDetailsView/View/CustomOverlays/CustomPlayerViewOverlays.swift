//
//  CustomPlayerViewOverlays.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct CustomPlayerViewOverlays<ControlsContent: PlayerControls>: PlayerViewOverlays {
    private let settings: SettingsModel
    let playerControls: ControlsContent
    let playerTopStartButtonConfiguration: CustomTopStartButtonConfiguration
    
    init(
        settings: SettingsModel,
        playerControls: ControlsContent,
        onClose: @escaping @MainActor () -> Void = {}
    ) {
        self.settings = settings
        self.playerControls = playerControls
        self.playerTopStartButtonConfiguration = CustomTopStartButtonConfiguration(
            useCustomTopStartButton: settings.useCustomPlayerControlsLayerView,
            onClose: onClose
        )
    }
    
    func controls(coordinator: ControlsOverlayCoordinator, pictureInPicture: PictureInPicture?) -> some View {
        if settings.useCustomPlayerControlsLayerView {
            CustomPlayerControlsLayerView(
                coordinator: coordinator,
                playerControls: playerControls,
                playerTopStartButtonConfiguration: playerTopStartButtonConfiguration,
                pictureInPicture: pictureInPicture
            )
        } else {
            DefaultTVControlsOverlayView(coordinator: coordinator, playerControls: playerControls)
        }
    }

    func error(
        coordinator: ErrorOverlayCoordinator,
        restrictedAccessConfiguration: StreamingStatusRestrictedAccessConfiguration
    ) -> some View {
        Group {
            if settings.useCustomErrorLayerView {
                CustomErrorLayerView(coordinator: coordinator)
            } else {
                DefaultErrorOverlayView(
                    coordinator: coordinator,
                    restrictedAccessConfiguration: restrictedAccessConfiguration
                )
            }
        }
        .playerTopStartButton(
            playerControls: playerControls,
            playerTopStartButtonConfiguration: playerTopStartButtonConfiguration
        )
    }
    
    func loading(coordinator: LoadingOverlayCoordinator) -> some View {
        Group {
            if settings.useCustomLoadingLayerView {
                Text("This is custom loading screen.")
            } else {
                DefaultLoadingOverlayView(coordinator: coordinator)
            }
        }
        .playerTopStartButton(
            playerControls: playerControls,
            playerTopStartButtonConfiguration: playerTopStartButtonConfiguration
        )
    }
}

struct CustomTopStartButtonConfiguration: PlayerTopStartButtonConfiguration {
    let useCustomTopStartButton: Bool
    let onClose: @MainActor () -> Void

    var topStartButtonType: TopStartButtonType {
        useCustomTopStartButton ? .custom : .pip
    }

    func topStartCustomButton() -> some View {
        CustomCloseTopStartButton(onClose: onClose)
    }
}

struct CustomCloseTopStartButton: View {
    let onClose: @MainActor () -> Void

    var body: some View {
        Button(action: {
            onClose()
        }) {
            Text("Close")
                .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }
}
