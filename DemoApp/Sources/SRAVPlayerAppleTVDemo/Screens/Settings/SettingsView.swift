//
//  SettingsView.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 22. 12. 25.
//

import SwiftUI
import SRAVPlayerSDK

struct SettingsView: View {
    @State private var path: [Int] = []
    @State private var selectedStreamState: StreamSource = .invalid
    private let userDefaults = UserDefaults.standard

    private enum UserDefaultsSRAVDemoKeys: String { case inlineModeForcesRotationToPortrait, fullScreenRotatesToLandscape, exitFullscreenWhenDeviceRotatesToPortrait, enterFullscreenWhenDeviceRotatesToLandscape, playerShouldDefaultToFullscreenOnAppear, videoShouldAutoStart, useCustomControlContentProvider, useCustomPlayerControlsLayerView, useCustomErrorLayerView, useCustomLoadingLayerView, useCustomCompleteLayerView, showThemeComparison, forcePlayerError, hideControls, hideSlider, hidePlayPauseToggle, hideTitle, hidePictureInPicture, hideSettingsMenu, hideFullscreenToggle, hideRemotePlayback, selectedStream }
    
    
    /* Setting toggles. */
    @State private var inlineModeForcesRotationToPortrait = false
    @State private var fullScreenRotatesToLandscape = false
    @State private var exitFullscreenWhenDeviceRotatesToPortrait = false
    @State private var enterFullscreenWhenDeviceRotatesToLandscape = false
    @State private var playerShouldDefaultToFullscreenOnAppear = false
    @State private var videoShouldAutoStart = false
    @State private var useCustomControlContentProvider = false
    @State private var useCustomPlayerControlsLayerView = false
    @State private var useCustomErrorLayerView = false
    @State private var useCustomLoadingLayerView = false
    @State private var useCustomCompleteLayerView = false
    @State private var showThemeComparison = false
    @State private var forcePlayerError = false
    @State private var hideControls = false
    @State private var hideSlider = false
    @State private var hidePlayPauseToggle = false
    @State private var hideTitle = false
    @State private var hidePictureInPicture = false
    @State private var hideSettingsMenu = false
    @State private var hideFullscreenToggle = false
    @State private var hideRemotePlayback = false
    @State private var selectedStream = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                Text("Video Player settings").font(.largeTitle).padding(.bottom, 40)
                
                Button("Start Video Player") {
                    path = [1]
                }
                .padding()
                .navigationDestination(for: Int.self) { _ in
                    /* Handle settings. */
                    let sRAVPlayerSettingsModel =
                    SRAVPlayerSettingsModel(
                        playerType: ((getVal(forKey: .playerShouldDefaultToFullscreenOnAppear)) ? .presentation : .inline),
                        inlineModeForcesRotationToPortrait: getVal(forKey: .inlineModeForcesRotationToPortrait),
                        fullScreenRotatesToLandscape: getVal(forKey: .fullScreenRotatesToLandscape),
                        exitFullscreenWhenDeviceRotatesToPortrait: getVal(forKey: .exitFullscreenWhenDeviceRotatesToPortrait),
                        enterFullscreenWhenDeviceRotatesToLandscape: getVal(forKey: .enterFullscreenWhenDeviceRotatesToLandscape))
                    
                    let demoSettings = DemoSettings(themeComparison: getVal(forKey: .showThemeComparison), forcePlayerError: getVal(forKey: .forcePlayerError), autoplay: getVal(forKey: .videoShouldAutoStart))
                    let customLayerSettings = SettingsModel(useCustomControlContentProvider: getVal(forKey: .useCustomControlContentProvider),
                                                            useCustomPlayerControlsLayerView: getVal(forKey: .useCustomPlayerControlsLayerView),
                                                            useCustomErrorLayerView: getVal(forKey: .useCustomErrorLayerView),
                                                            useCustomLoadingLayerView: getVal(forKey: .useCustomLoadingLayerView),
                                                            useCustomCompleteLayerView: getVal(forKey: .useCustomCompleteLayerView),
                                                            hideControls: getVal(forKey: .hideControls),
                                                            hideSlider: getVal(forKey: .hideSlider),
                                                            hidePlayPauseToggle: getVal(forKey: .hidePlayPauseToggle),
                                                            hideTitle: getVal(forKey: .hideTitle),
                                                            hidePictureInPicture: getVal(forKey: .hidePictureInPicture),
                                                            hideSettingsMenu: getVal(forKey: .hideSettingsMenu),
                                                            hideFullscreenToggle: getVal(forKey: .hideFullscreenToggle),
                                                            hideRemotePlayback:getVal(forKey: .hideRemotePlayback))
                    PlayerDetailsView(settings: sRAVPlayerSettingsModel, demoSettings: demoSettings,  customUISettings: customLayerSettings, streamUrl: selectedStreamState.url)
                }
                .padding(.bottom, 40)
                
                Section(header: Text("Stream selection")) {
                    Picker("Stream auswählen", selection:
                        Binding(
                            get: {
                                selectedStreamState
                            },
                            set: { newValue in
                                selectedStreamState = newValue
                                store(val: newValue.rawValue , key: .selectedStream)
                            }
                        )
                    ) {
                        ForEach(StreamSource.allCases) { stream in
                            Text(stream.title)
                                .tag(stream)
                        }
                    }
                    .pickerStyleModifier()
                }
                
                Spacer().frame(height: 80)
                  
                /*
                VStack(spacing: 20) {
                    Section(header: Text("Full screen transitions")) {
                        Toggle("Inline mode forces rotation to portrait", isOn: $inlineModeForcesRotationToPortrait).onChange(of: inlineModeForcesRotationToPortrait) { val in store(val: val, key: .inlineModeForcesRotationToPortrait)}
                        Toggle("FullScreen forces rotation to landscape", isOn: $fullScreenRotatesToLandscape).onChange(of: fullScreenRotatesToLandscape) { val in store(val: val, key: .fullScreenRotatesToLandscape)}
                        Toggle("Exit full screen when device orientates to portrait", isOn: $exitFullscreenWhenDeviceRotatesToPortrait).onChange(of: exitFullscreenWhenDeviceRotatesToPortrait) { val in store(val: val, key: .exitFullscreenWhenDeviceRotatesToPortrait)}
                        Toggle("Enter fullscreen when device rotates to landscape", isOn: $enterFullscreenWhenDeviceRotatesToLandscape).onChange(of: enterFullscreenWhenDeviceRotatesToLandscape) { val in store(val: val, key: .enterFullscreenWhenDeviceRotatesToLandscape)}
                    }
                }.padding(.bottom, 40)
                */
                
                VStack(spacing: 20) {
                    Section(header: Text("Other settings")) {
//                        Toggle("Player should default to fullscreen on appear", isOn: $playerShouldDefaultToFullscreenOnAppear).onChange(of: playerShouldDefaultToFullscreenOnAppear) { val in store(val: val, key: .playerShouldDefaultToFullscreenOnAppear)}
                        Toggle("Video should autostart on appear", isOn: $videoShouldAutoStart).onChange(of: videoShouldAutoStart) { val in store(val: val, key: .videoShouldAutoStart)}
                        Toggle("Theme: Default vs. Custom", isOn: $showThemeComparison).onChange(of: showThemeComparison) { val in store(val: val, key: .showThemeComparison)}
                        Toggle("Force Player Error", isOn: $forcePlayerError).onChange(of: forcePlayerError) { val in store(val: val, key: .forcePlayerError)}
                    }
                }.padding(.bottom, 40)
                
                VStack(spacing: 20) {
                    Section(header: Text("UI Customisation")) {
                        Toggle("Use custom Control Content (on default layer)", isOn: $useCustomControlContentProvider).onChange(of: useCustomControlContentProvider) { val in store(val: val, key: .useCustomControlContentProvider)}
                        Toggle("Use custom player controls layer view", isOn: $useCustomPlayerControlsLayerView).onChange(of: useCustomPlayerControlsLayerView) { val in store(val: val, key: .useCustomPlayerControlsLayerView)}
                        Toggle("Use custom error layer view", isOn: $useCustomErrorLayerView).onChange(of: useCustomErrorLayerView) { val in store(val: val, key: .useCustomErrorLayerView)}
                        Toggle("Use custom loading layer view", isOn: $useCustomLoadingLayerView).onChange(of: useCustomLoadingLayerView) { val in store(val: val, key: .useCustomLoadingLayerView)}
                        Toggle("Use custom complete layer view", isOn: $useCustomCompleteLayerView).onChange(of: useCustomCompleteLayerView) { val in store(val: val, key: .useCustomCompleteLayerView)}
                    }
                }.padding(.bottom, 40)
                
                /*
                VStack(spacing: 20) {
                    Section(header: Text("Playback Controls Configuration")) {
                        Toggle("Hide Control Layer", isOn: $hideControls).onChange(of: hideControls) { val in store(val: val, key: .hideControls)}
                        Toggle("Hide Slider", isOn: $hideSlider).onChange(of: hideSlider) { val in store(val: val, key: .hideSlider)}
                        Toggle("Hide Play Pause Toggle", isOn: $hidePlayPauseToggle).onChange(of: hidePlayPauseToggle) { val in store(val: val, key: .hidePlayPauseToggle)}
                        Toggle("Hide Title", isOn: $hideTitle).onChange(of: hideTitle) { val in store(val: val, key: .hideTitle)}
                        Toggle("Hide Picture in Picture", isOn: $hidePictureInPicture).onChange(of: hidePictureInPicture) { val in store(val: val, key: .hidePictureInPicture)}
                        Toggle("Hide Settings Menu", isOn: $hideSettingsMenu).onChange(of: hideSettingsMenu) { val in store(val: val, key: .hideSettingsMenu)}
//                        Toggle("Hide Fullscreen Toggle", isOn: $hideFullscreenToggle).onChange(of: hideFullscreenToggle) { val in store(val: val, key: .hideFullscreenToggle)}
//                        Toggle("Hide Remote Playback", isOn: $hideRemotePlayback).onChange(of: hideRemotePlayback) { val in store(val: val, key: .hideRemotePlayback)}
                    }
                }.padding(.bottom, 40)
                */
            }
            .onAppear {
                selectedStreamState = StreamSource(rawValue:getString(forKey: .selectedStream)) ?? .invalid
                
                /* Get initial values. */
                inlineModeForcesRotationToPortrait = getVal(forKey: .inlineModeForcesRotationToPortrait)
                fullScreenRotatesToLandscape = getVal(forKey: .fullScreenRotatesToLandscape)
                exitFullscreenWhenDeviceRotatesToPortrait = getVal(forKey: .exitFullscreenWhenDeviceRotatesToPortrait)
                enterFullscreenWhenDeviceRotatesToLandscape = getVal(forKey: .enterFullscreenWhenDeviceRotatesToLandscape)
                playerShouldDefaultToFullscreenOnAppear = getVal(forKey: .playerShouldDefaultToFullscreenOnAppear)
                videoShouldAutoStart = getVal(forKey: .videoShouldAutoStart)
                useCustomControlContentProvider = getVal(forKey: .useCustomControlContentProvider)
                useCustomPlayerControlsLayerView = getVal(forKey: .useCustomPlayerControlsLayerView)
                useCustomErrorLayerView = getVal(forKey: .useCustomErrorLayerView)
                useCustomLoadingLayerView = getVal(forKey: .useCustomLoadingLayerView)
                useCustomCompleteLayerView = getVal(forKey: .useCustomCompleteLayerView)
                showThemeComparison = getVal(forKey: .showThemeComparison)
                forcePlayerError = getVal(forKey: .forcePlayerError)
                hideControls = getVal(forKey: .hideControls)
                hideSlider = getVal(forKey: .hideSlider)
                hidePlayPauseToggle = getVal(forKey: .hidePlayPauseToggle)
                hideTitle = getVal(forKey: .hideTitle)
                hidePictureInPicture = getVal(forKey: .hidePictureInPicture)
                hideSettingsMenu = getVal(forKey: .hideSettingsMenu)
                hideFullscreenToggle = getVal(forKey: .hideFullscreenToggle)
                hideRemotePlayback = getVal(forKey: .hideRemotePlayback)
                selectedStream = getVal(forKey: .selectedStream)
            }
            .font(Font.system(size: 20, weight: .regular))
            
            /*
            Button("Start Video Player") {
                path = [1]
            }
            .padding()
            .foregroundStyle(.white)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .navigationDestination(for: Int.self) { _ in
                /* Handle settings. */
                let sRAVPlayerSettingsModel =
                SRAVPlayerSettingsModel(
                    playerType: ((getVal(forKey: .playerShouldDefaultToFullscreenOnAppear)) ? .presentation : .inline),
                    inlineModeForcesRotationToPortrait: getVal(forKey: .inlineModeForcesRotationToPortrait),
                    fullScreenRotatesToLandscape: getVal(forKey: .fullScreenRotatesToLandscape),
                    exitFullscreenWhenDeviceRotatesToPortrait: getVal(forKey: .exitFullscreenWhenDeviceRotatesToPortrait),
                    enterFullscreenWhenDeviceRotatesToLandscape: getVal(forKey: .enterFullscreenWhenDeviceRotatesToLandscape),
                    videoShouldAutoStart: getVal(forKey: .videoShouldAutoStart)
                )
                
                let demoSettings = DemoSettings(themeComparison: getVal(forKey: .showThemeComparison), forcePlayerError: getVal(forKey: .forcePlayerError))
                let customLayerSettings = SettingsModel(useCustomControlContentProvider: getVal(forKey: .useCustomControlContentProvider),
                                                        useCustomPlayerControlsLayerView: getVal(forKey: .useCustomPlayerControlsLayerView),
                                                        useCustomErrorLayerView: getVal(forKey: .useCustomErrorLayerView),
                                                        useCustomLoadingLayerView: getVal(forKey: .useCustomLoadingLayerView),
                                                        useCustomCompleteLayerView: getVal(forKey: .useCustomCompleteLayerView),
                                                        hideControls: getVal(forKey: .hideControls),
                                                        hideSlider: getVal(forKey: .hideSlider),
                                                        hidePlayPauseToggle: getVal(forKey: .hidePlayPauseToggle),
                                                        hideTitle: getVal(forKey: .hideTitle),
                                                        hidePictureInPicture: getVal(forKey: .hidePictureInPicture),
                                                        hideSettingsMenu: getVal(forKey: .hideSettingsMenu),
                                                        hideFullscreenToggle: getVal(forKey: .hideFullscreenToggle),
                                                        hideRemotePlayback:getVal(forKey: .hideRemotePlayback))
                PlayerDetailsView(settings: sRAVPlayerSettingsModel, demoSettings: demoSettings,  customUISettings: customLayerSettings, streamUrl: selectedStreamState.url)
            }
            */
        }
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
    
    private func store(val: String, key: UserDefaultsSRAVDemoKeys) {
        userDefaults.set(val, forKey: key.rawValue)
    }

    private func getString(forKey key: UserDefaultsSRAVDemoKeys) -> String {
        userDefaults.string(forKey: key.rawValue) ?? StreamSource.elephantsDream.rawValue
    }
}

#Preview {
    SettingsView()
}
