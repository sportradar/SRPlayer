//
//  NavigationDelegate.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 14. 10. 25.
//

import Foundation
import SRAVPlayerSDK

protocol NavigationDelegate: AnyObject {
    func openAVPlayerDetails(viewModel: SRAVPlayerSettingsModel, customLayerSettingsModel: SettingsModel)
}
