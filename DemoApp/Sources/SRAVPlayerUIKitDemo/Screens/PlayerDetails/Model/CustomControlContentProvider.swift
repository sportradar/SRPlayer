//
//  CustomPlayerControlContentProvider.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 01.12.25.
//

import SwiftUI

import SRAVPlayerSDK

struct CustomControlContentProvider: PlayerControlContentProvider {
    private let useCustomControls: Bool
    private let defaultControlProvider = PlayerControlContentProviderDefault()
    
    init(useCustomControls: Bool) {
        self.useCustomControls = useCustomControls
    }
    
    func playPause(state: Binding<PlayPauseButtonState>) -> some View {
        if useCustomControls {
            CustomPlayPauseToggleContent(state: state)
        } else {
            defaultControlProvider.playPause(state: state)
        }
    }
    
    func fullscreen(isActive: Binding<Bool>) -> some View {
        if useCustomControls {
            CustomFullscreenToggleContent(state: isActive)
        } else {
            defaultControlProvider.fullscreen(isActive: isActive)
        }
    }
    
    func settings() -> some View {
        if useCustomControls {
            CustomSettingsControlContent()
        } else {
            defaultControlProvider.settings()
        }
    }
    
    func pip(isActive: Binding<Bool>) -> some View {
        if useCustomControls {
            CustomPipContent(state: isActive)
        } else {
            defaultControlProvider.pip(isActive: isActive)
        }
    }
    
    struct CustomPlayPauseToggleContent : View {
        @Environment(\.theme) private var theme
        @Binding private var state : PlayPauseButtonState
        
        init(state: Binding<PlayPauseButtonState>) {
            self._state = state
        }
        
        var body: some View {
            Text("\(state == .init(state: .paused) ? "Custom Play" : "Custom Pause")")
                .foregroundStyle(theme.colors.tint)
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

