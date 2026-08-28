//
//  SettingsViewController.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 13. 10. 25.
//

import UIKit
import SRAVPlayerSDK

final class SettingsViewController: UIViewController {
    private lazy var settingsView: SettingsView = {
        let v = SettingsView()
        v.delegate = self
        return v
    }()
    
    // MARK: - Lifecycle.
    
    override func loadView() {
        view = settingsView
    }
}

extension SettingsViewController: NavigationDelegate {
    func openAVPlayerDetails(orientationConfiguration: PlayerOrientationConfiguration, customLayerSettingsModel: SettingsModel) {
        navigationController?.pushViewController(
            PlayerDetailsViewController(
                orientationConfiguration: orientationConfiguration,
                customLayerSettingsModel: customLayerSettingsModel
            ),
            animated: true
        )
    }
}
