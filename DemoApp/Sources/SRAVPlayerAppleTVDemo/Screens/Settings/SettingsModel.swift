//
//  SettingsModel.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 22. 12. 25.
//

import Foundation

struct SettingsModel {
    let useCustomControlContentProvider: Bool
    let useCustomPlayerControlsLayerView: Bool
    let useCustomErrorLayerView: Bool
    let useCustomLoadingLayerView: Bool
    let useCustomCompleteLayerView: Bool
    
    let hideControls: Bool
    let hideSlider: Bool
    let hidePlayPauseToggle: Bool
    let hideTitle: Bool
    let hidePictureInPicture: Bool
    let hideSettingsMenu: Bool
    let hideFullscreenToggle: Bool
    let hideRemotePlayback: Bool
}

extension SettingsModel {
    var shouldUseCustomOverviewLayerView: Bool {
        useCustomPlayerControlsLayerView || useCustomErrorLayerView || useCustomLoadingLayerView || useCustomCompleteLayerView
    }
}
