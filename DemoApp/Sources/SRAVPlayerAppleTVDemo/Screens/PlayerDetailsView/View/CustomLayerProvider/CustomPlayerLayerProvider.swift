//
//  CustomPlayerLayerProvider.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct CustomPlayerLayerProvider<ControlContentProvider: PlayerControlContentProvider>: PlayerLayerProvider {
    private let settings: SettingsModel
    
    init(settings: SettingsModel) {
        self.settings = settings
    }
    
    func controls(viewModel: SRAVOverlayLayerViewModel, controlContentProvider: ControlContentProvider) -> some View {
        if settings.useCustomPlayerControlsLayerView {
            CustomPlayerControlsLayerView(viewModel: viewModel)
        } else {
            SRAVTVPlayerControlView(viewModel: viewModel, controlContentProvider: controlContentProvider)
        }
    }
    
    func error(viewModel: SRAVOverlayLayerViewModel) -> some View {
        if settings.useCustomErrorLayerView {
            CustomErrorLayerView(viewModel: viewModel)
        } else {
            SRAVPlayerErrorLayerView(viewModel: viewModel)
        }
    }
    
    func loading() -> some View {
        if settings.useCustomLoadingLayerView {
            Text("This is custom loading screen.")
        } else {
            SRAVPlayerLoadingView()
        }
    }
}
