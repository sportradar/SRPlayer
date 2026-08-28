//
//  PlayerDetailsViewController.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 14. 10. 25.
//

import UIKit
import SRAVPlayerSDK
import SwiftUI

final class PlayerDetailsViewController: UIViewController {
    private let orientationConfiguration: PlayerOrientationConfiguration
    private let customLayerSettingsModel: SettingsModel
    private lazy var playerDetailsView: PlayerDetailsView = PlayerDetailsView(
        orientationConfiguration: orientationConfiguration,
        settingsModel: customLayerSettingsModel
    )
    
    init(orientationConfiguration: PlayerOrientationConfiguration, customLayerSettingsModel: SettingsModel) {
        self.orientationConfiguration = orientationConfiguration
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
        playerDetailsView.onClose = { [weak self] in
            guard let self else { return }
            if let navigationController {
                navigationController.popViewController(animated: true)
            } else {
                dismiss(animated: true)
            }
        }
        /* Hosting view controller must be added as a child to prevent:
         Presenting view controller SwiftUI.PlatformAlertController from detached view controller is not supported…
         */
        playerDetailsView.onHostingControllerChanged = { [weak self] hosting in
            guard let self else { return }
            if let hosting {
                addChild(hosting)
                hosting.didMove(toParent: self)
            }
        }
        // Initial hosting is created during PlayerDetailsView.init (before this callback was set).
        if let hosting = playerDetailsView.hostingViewController {
            addChild(hosting)
            hosting.didMove(toParent: self)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Tear down when leaving the screen for good (pop / dismiss). Skip while still in hierarchy
        // (e.g. covered by a presented sheet) so PiP / playback can continue if needed.
        if isMovingFromParent || isBeingDismissed {
            playerDetailsView.destroySession()
        }
    }
}
