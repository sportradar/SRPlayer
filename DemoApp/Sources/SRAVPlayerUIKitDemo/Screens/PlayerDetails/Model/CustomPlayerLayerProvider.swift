//
//  CustomLayerProvider.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 01.12.25.
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
            PlayerControlView(viewModel: viewModel, controlContentProvider: controlContentProvider)
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
