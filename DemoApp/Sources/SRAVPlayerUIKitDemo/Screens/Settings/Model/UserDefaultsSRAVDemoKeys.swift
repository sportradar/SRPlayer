//
//  UserDefaultsSRAVDemoKeys.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 14. 10. 25.
//

import Foundation

enum UserDefaultsSRAVDemoKeys: String, CaseIterable {
    case inlineModeForcesRotationToPortrait, fullScreenRotatesToLandscape, exitFullscreenWhenDeviceRotatesToPortrait, enterFullscreenWhenDeviceRotatesToLandscape, playerShouldDefaultToFullscreenOnAppear, videoShouldAutoStart,
         useCustomPlayerControlsLayerView, useCustomErrorLayerView, useCustomLoadingLayerView, useCustomCompleteLayerView
    
    var title: String {
        switch self {
        case .inlineModeForcesRotationToPortrait: return "Inline mode forces rotation to portrait"
        case .fullScreenRotatesToLandscape: return "FullScreen forces rotation to landscape"
        case .exitFullscreenWhenDeviceRotatesToPortrait: return "Exit full screen when device orientates to portrait"
        case .enterFullscreenWhenDeviceRotatesToLandscape: return "Enter fullscreen when device rotates to landscape"
        case .playerShouldDefaultToFullscreenOnAppear: return "Player should default to fullscreen on appear"
        case .videoShouldAutoStart: return "Video should autostart on appear"
        case .useCustomPlayerControlsLayerView: return "Use custom player control layer view"
        case .useCustomErrorLayerView: return "Use custom error layer view"
        case .useCustomLoadingLayerView: return "Use custom loading layer view"
        case .useCustomCompleteLayerView: return "Use custom complete layer view"
            
        }
    }
        
    var id: Int {
        switch self {
        case .inlineModeForcesRotationToPortrait: return 0
        case .fullScreenRotatesToLandscape: return 1
        case .exitFullscreenWhenDeviceRotatesToPortrait: return 2
        case .enterFullscreenWhenDeviceRotatesToLandscape: return 3
        case .playerShouldDefaultToFullscreenOnAppear: return 4
        case .videoShouldAutoStart: return 5
        case .useCustomPlayerControlsLayerView: return 6
        case .useCustomErrorLayerView: return 7
        case .useCustomLoadingLayerView: return 8
        case .useCustomCompleteLayerView: return 9
        }
    }
    
    static func getKey(fromId id: Int) -> UserDefaultsSRAVDemoKeys? {
        switch id {
        case 0: return .inlineModeForcesRotationToPortrait
        case 1: return .fullScreenRotatesToLandscape
        case 2: return .exitFullscreenWhenDeviceRotatesToPortrait
        case 3: return .enterFullscreenWhenDeviceRotatesToLandscape
        case 4: return .playerShouldDefaultToFullscreenOnAppear
        case 5: return .videoShouldAutoStart
        case 6: return .useCustomPlayerControlsLayerView
        case 7: return .useCustomErrorLayerView
        case 8: return .useCustomLoadingLayerView
        case 9: return .useCustomCompleteLayerView
        default: return nil
        }
    }
}
