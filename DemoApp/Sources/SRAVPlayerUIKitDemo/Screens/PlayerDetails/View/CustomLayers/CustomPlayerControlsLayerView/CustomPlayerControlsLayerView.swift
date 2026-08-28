//
//  CustomPlayerControlsLayerView.swift
//  SRAVPlayerDemo
//
//  Created by Boris Filipovic on 7. 11. 25.
//

import SwiftUI
import SRAVPlayerSDK

struct CustomPlayerControlsLayerView<
    ControlsContent: PlayerControls,
    TopStartButtonConfiguration: PlayerTopStartButtonConfiguration
>: View {
    @State private var showingConfirmationDialog = false
  
    private let coordinator: ControlsOverlayCoordinator
    private let playerControls: ControlsContent
    private let playerTopStartButtonConfiguration: TopStartButtonConfiguration
    private let pictureInPicture: PictureInPicture?
    
    private var controlsConfiguration: PlaybackControlsConfiguration {
        return coordinator.assetConfiguration?.playbackUiConfiguration ?? .default
    }
    
    init(
        coordinator: ControlsOverlayCoordinator,
        playerControls: ControlsContent,
        playerTopStartButtonConfiguration: TopStartButtonConfiguration,
        pictureInPicture: PictureInPicture? = nil
    ) {
        self.coordinator = coordinator
        self.playerControls = playerControls
        self.playerTopStartButtonConfiguration = playerTopStartButtonConfiguration
        self.pictureInPicture = pictureInPicture
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 14) {
                    PlayerTopStartButton(
                        playerControls: playerControls,
                        playerTopStartButtonConfiguration: playerTopStartButtonConfiguration,
                        pictureInPicture: pictureInPicture,
                        isPictureInPictureEnabled: controlsConfiguration.pictureInPicture
                    )

                    Text("Video Title")
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 14) {
                        Button(action: {
                            showingConfirmationDialog.toggle()
                        }) {
                            Image(systemName: "gears")
                                .foregroundColor(.white)
                        }
                        .confirmationDialog("Confirmation dialog", isPresented: $showingConfirmationDialog, actions: {
                            Button("Red") {
                                print("Red button pressed. ")
                            }
                            Button("Green") {
                                print("Green button pressed. ")
                            }

                            Button("Purple") {
                                print("Purple button pressed. ")
                            }

                            Button("Default", role: .destructive) {
                                print("Default button pressed. ")
                            }
                        }).foregroundStyle(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
            }
            if coordinator.controlUIState.isBuffering {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 50, height: 50)
            } else {
                // Center Controls: Play/Pause
            Button(action: { coordinator.onInteraction(.playPauseToggle) }) {
                let text = coordinator.controlUIState.playPauseButtonState == .paused ? "Play" : "Pause"
                    Text(text)
                        .frame(width: 50, height: 59)
                        .foregroundStyle(.white)
                        .frame(width: 120, height: 120)
                        .multilineTextAlignment(.center)
                        .background(
                            Circle()
                                .fill(.purple.opacity(0.4))
                        )
                    
                }.buttonStyle(.plain)
            }
        }
        .background(Color.black.opacity(0.4))
    }
}
