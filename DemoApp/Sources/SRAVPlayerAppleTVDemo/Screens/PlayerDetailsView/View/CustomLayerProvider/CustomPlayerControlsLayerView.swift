//
//  CustomPlayerControlsLayerView.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct CustomPlayerControlsLayerView: View {
    @State private var showingConfirmationDialog = false
  
    @ObservedObject private var viewModel: SRAVOverlayLayerViewModel
    
    init(viewModel: SRAVOverlayLayerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Video Title")
                        .foregroundColor(.white)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Spacer()
                    
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

                        
//                        if let pipController = viewModel.pictureInPicture {
//                            PiPButton(controller: pipController)
//                                .foregroundColor(.white)
//                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 50, height: 50)
            } else {
                // Center Controls: Play/Pause
                Button(action: { viewModel.togglePlayPause() }) {
                    let text = viewModel.controlState?.playPauseButton.state == .paused ? "Play" : "Pause"
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
            
            //Bottom Controls view
//            VStack {
//                Spacer()
//                PlayerControlViewBottom().environmentObject(viewModel)
//            }
            
        }
        .background(Color.black.opacity(0.4))
    }
}
