//
//  CustomPlayerControls.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 01.12.25.
//

import SwiftUI

import SRAVPlayerSDK

struct CustomPlayerControls: PlayerControls {
    private let useCustomControls: Bool
    private let defaultPlayerControls = DefaultPlayerControls()
    let settingDialogConfiguration = DefaultSettingDialogConfiguration()
    let fullscreenMediaInfoConfiguration = DefaultFullscreenMediaInfoConfiguration()
    
    init(useCustomControls: Bool) {
        self.useCustomControls = useCustomControls
    }
    
    func playPause(state: Binding<PlayPauseButtonState>, isBuffering: Bool) -> some View {
        if useCustomControls {
            CustomPlayPauseToggleContent(state: state, isBuffering: isBuffering)
        } else {
            defaultPlayerControls.playPause(state: state, isBuffering: isBuffering)
        }
    }
    
    func fullscreen(isActive: Binding<Bool>) -> some View {
        if useCustomControls {
            CustomFullscreenToggleContent(state: isActive)
        } else {
            defaultPlayerControls.fullscreen(isActive: isActive)
        }
    }
    
    func settings() -> some View {
        if useCustomControls {
            CustomSettingsControlContent()
        } else {
            defaultPlayerControls.settings()
        }
    }
    
    func pip(isActive: Binding<Bool>) -> some View {
        if useCustomControls {
            CustomPipContent(state: isActive)
        } else {
            defaultPlayerControls.pip(isActive: isActive)
        }
    }
    
    struct CustomPlayPauseToggleContent : View {
        @Environment(\.theme) private var theme
        @Binding private var state : PlayPauseButtonState
        private let isBuffering: Bool
        
        init(state: Binding<PlayPauseButtonState>, isBuffering: Bool) {
            self._state = state
            self.isBuffering = isBuffering
        }
        
        var body: some View {
            Text(isBuffering ? "Custom Buffering" : "\(state == .paused ? "Custom Play" : "Custom Pause")")
                .foregroundStyle(theme.colors.iconButtonPrimaryColor)
        }
    }
    
    struct CustomFullscreenToggleContent : View {
        @Environment(\.theme) private var theme
        @Binding private var state : Bool
        
        init(state: Binding<Bool>) {
            self._state = state
        }
        
        var body: some View {
            (state ? Color.red : Color.green)
                .frame(width: 60)
        }
    }
    
    struct CustomSettingsControlContent : View {
        @Environment(\.theme) private var theme
        
        var body: some View {
            Circle()
                .fill(Color.orange)
                .frame(height: 40)
        }
    }
    
    struct CustomPipContent : View {
        @Binding private var state : Bool
        
        init(state: Binding<Bool>) {
            self._state = state
        }
        
        var body: some View {
            Circle()
                .fill(state ? Color.brown : Color.purple)
                .frame(height: 40)
        }
    }
}

