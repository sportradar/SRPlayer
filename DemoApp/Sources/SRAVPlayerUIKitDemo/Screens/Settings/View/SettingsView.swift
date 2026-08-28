//
//  SettingsView.swift
//  SRAVPlayerUIKitDemo
//
//  Created by Boris Filipovic on 13. 10. 25.
//

import UIKit
import SRAVPlayerSDK

final class SettingsView: UIView {
    weak var delegate: NavigationDelegate?
    private let userDefaults = UserDefaults.standard
    private lazy var hStackView: UIStackView = createStackView(axis: .vertical)
    private lazy var mainTitle: UILabel = createLabel(text: "Video Player settings", font: .preferredFont(forTextStyle: .title1))
    
    private lazy var scrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        return v
    }()
    
    private lazy var startButton: UIButton = {
        let v = UIButton()
        v.setTitle("Start Video Player", for: .normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 26.0, *) {
            v.configuration = .prominentGlass()
        } else {
            // Fallback on earlier versions
            v.backgroundColor = .green
            v.layer.cornerRadius = 8
        }
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        /* Change background color. */
        backgroundColor = .white
        
        /* Add subviews. */
        addSubview(scrollView)
        addSubview(startButton)
        hStackView.addArrangedSubview(mainTitle)
        scrollView.addSubview(hStackView)

        /* Switches. */
        UserDefaultsSRAVDemoKeys.allCases.forEach { element in
            let hStack = createStackView(axis: .horizontal)
            
            let v = createLabel(text: element.title, font: .preferredFont(forTextStyle: .body))
            
            let switchV = UISwitch()
            switchV.tag = element.id
            switchV.isOn = getVal(forKey: element)
            switchV.addTarget(self, action: #selector(switchChagned), for: .valueChanged)
            switchV.widthAnchor.constraint(equalToConstant: 70).isActive = true
            
            hStack.addArrangedSubview(v)
            hStack.addArrangedSubview(switchV)
            
            hStackView.addArrangedSubview(hStack)
            hStack.widthAnchor.constraint(equalTo: hStackView.widthAnchor).isActive = true
        }
        
        /* Start video button. */
        startButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
        
    private func setupConstraints() {
        scrollView.pinSafe(to: self, insets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))

        startButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

        hStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
    }
}

// MARK: - (Private) Actions.
private extension SettingsView {
    @objc private func switchChagned(_ sender: UISwitch) {
        guard let key = UserDefaultsSRAVDemoKeys.getKey(fromId: sender.tag) else { return }
        store(val: sender.isOn, key: key)
        
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        /* Handle settings. */
        let orientationConfiguration =
        PlayerOrientationConfiguration(
            startInFullscreen: getVal(forKey: .playerShouldDefaultToFullscreenOnAppear),
            inlineModeForcesRotationToPortrait: getVal(forKey: .inlineModeForcesRotationToPortrait),
            allowRotationToLandscape: getVal(forKey: .allowRotationToLandscape),
            exitFullscreenWhenDeviceRotatesToPortrait: getVal(forKey: .exitFullscreenWhenDeviceRotatesToPortrait),
            enterFullscreenOnLandscapeRotation: getVal(forKey: .enterFullscreenOnLandscapeRotation)
        )
        
        let customLayerSettingsModel = SettingsModel(useCustomPlayerControls: false, useCustomPlayerControlsLayerView: getVal(forKey: .useCustomPlayerControlsLayerView), useCustomErrorLayerView: getVal(forKey: .useCustomErrorLayerView), useCustomLoadingLayerView: getVal(forKey: .useCustomLoadingLayerView), useCustomCompleteLayerView: getVal(forKey: .useCustomCompleteLayerView), hideControls: false, hideSlider: false, hidePlayPauseToggle: false, hideTitle: false, hidePictureInPicture: false, hideSettingsMenu: false, hideFullscreenToggle: false, hideRemotePlayback: false, autoplay: getVal(forKey: .videoShouldAutoStart))
        
        delegate?.openAVPlayerDetails(orientationConfiguration: orientationConfiguration, customLayerSettingsModel: customLayerSettingsModel)
    }
}

// MARK: - (Private) User defaults.
private extension SettingsView {
    private func store(val: Bool, key: UserDefaultsSRAVDemoKeys) {
        userDefaults.set(val, forKey: key.rawValue)
    }
    
    private func getVal(forKey key: UserDefaultsSRAVDemoKeys) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }
}

// MARK: - (Private) Helpet methods.
private extension SettingsView {
    private func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = axis
        v.clipsToBounds = true
        v.spacing = 20
        v.alignment = .center
        v.distribution = .fill
        return v
    }
    
    private func createLabel(text: String, font: UIFont) -> UILabel {
        let v = UILabel()
        v.text = text
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = font
        v.numberOfLines = 0
        return v
    }
}
