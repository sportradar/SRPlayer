//
//  PlayerDetailsViewController.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 14. 10. 25.
//

import UIKit
import SRAVPlayerSDK

final class PlayerDetailsViewController: UIViewController {
    private let playerSettings: SRAVPlayerSettingsModel
    private let customLayerSettingsModel: SettingsModel
    private lazy var playerDetailsView: PlayerDetailsView = PlayerDetailsView(settings: playerSettings, settingsModel: customLayerSettingsModel)
    
    init(settings: SRAVPlayerSettingsModel, customLayerSettingsModel: SettingsModel) {
        self.playerSettings = settings
        self.customLayerSettingsModel = customLayerSettingsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = playerDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Hosting view controller must be added to parent view as child view controller to prevent this issue in the future:
         Presenting view controller SwiftUI.PlatformAlertController from detached view controller is not supported, and may result in incorrect safe area insets and a corrupt root presentation.
         */
        addChild(playerDetailsView.hostingViewController)
    }
}
