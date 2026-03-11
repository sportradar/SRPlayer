//
//  SettingsView.swift
//  SRAVPlayerDemo
//
//  Created by Boris Filipovic on 10. 10. 25.
//

import SwiftUI
import SRAVPlayerSDK

struct SettingsView: View {
    @State private var path: [Int] = []
    @State private var selectedStreamState: StreamSource = .invalid
    private let userDefaults = UserDefaults.standard

    private enum UserDefaultsSRAVDemoKeys: String { case inlineModeForcesRotationToPortrait, fullScreenRotatesToLandscape, exitFullscreenWhenDeviceRotatesToPortrait, enterFullscreenWhenDeviceRotatesToLandscape, playerShouldDefaultToFullscreenOnAppear, videoShouldAutoStart, useCustomControlContentProvider, useCustomPlayerControlsLayerView, useCustomErrorLayerView, useCustomLoadingLayerView, useCustomCompleteLayerView, showThemeComparison, forcePlayerError, hideControls, hideSlider, hidePlayPauseToggle, hideTitle, hidePictureInPicture, hideSettingsMenu, hideFullscreenToggle, hideRemotePlayback, selectedStream }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section(header: Text("Stream")) {
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
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Full screen transitions")) {
                    Toggle("Inline mode forces rotation to portrait", isOn:
                            Binding(
                                get: {getVal(forKey: .inlineModeForcesRotationToPortrait)},
                                set: {selected,_ in store(val: selected, key: .inlineModeForcesRotationToPortrait) }
                            )
                    )
                    
                    Toggle("FullScreen forces rotation to landscape", isOn:
                            Binding(
                                get: {getVal(forKey: .fullScreenRotatesToLandscape)},
                                set: {selected,_ in store(val: selected, key: .fullScreenRotatesToLandscape) }
                            )
                    )

                    Toggle("Exit full screen when device orientates to portrait", isOn:
                            Binding(
                                get: {getVal(forKey: .exitFullscreenWhenDeviceRotatesToPortrait)},
                                set: {selected,_ in store(val: selected, key: .exitFullscreenWhenDeviceRotatesToPortrait) }
                            )
                    )
                    
                    Toggle("Enter fullscreen when device rotates to landscape", isOn:
                            Binding(
                                get: {getVal(forKey: .enterFullscreenWhenDeviceRotatesToLandscape)},
                                set: {selected,_ in store(val: selected, key: .enterFullscreenWhenDeviceRotatesToLandscape) }
                            )
                    )
                }
                .tint(Color.purple)
                
                Section(header: Text("Other settings")) {
                    Toggle("Player should default to fullscreen on appear", isOn:
                            Binding(
                                get: {getVal(forKey: .playerShouldDefaultToFullscreenOnAppear)},
                                set: {selected,_ in store(val: selected, key: .playerShouldDefaultToFullscreenOnAppear) }
                            )
                    )
                    
                    Toggle("Video should autostart on appear", isOn:
                            Binding(
                                get: {getVal(forKey: .videoShouldAutoStart)},
                                set: {selected,_ in store(val: selected, key: .videoShouldAutoStart) }
                            )
                    )
                    
                    Toggle("Theme: Default vs. Custom", isOn:
                            Binding(
                                get: {getVal(forKey: .showThemeComparison)},
                                set: {selected,_ in store(val: selected, key: .showThemeComparison) }
                            )
                    )
                    
                    Toggle("Force Player Error", isOn:
                            Binding(
                                get: {getVal(forKey: .forcePlayerError)},
                                set: {selected,_ in store(val: selected, key: .forcePlayerError) }
                            )
                    )
                }
                .tint(Color.red)
                
                Section(header: Text("UI Customisation")) {
                    Toggle("Use custom Control Content (on default layer)", isOn:
                            Binding(
                                get: {getVal(forKey: .useCustomControlContentProvider)},
                                set: {selected,_ in store(val: selected, key: .useCustomControlContentProvider) }
                            )
                    )
                    
                    Toggle("Use custom player controls layer view", isOn:
                            Binding(
                                get: {getVal(forKey: .useCustomPlayerControlsLayerView)},
                                set: {selected,_ in store(val: selected, key: .useCustomPlayerControlsLayerView) }
                            )
                    )
                    
                    Toggle("Use custom error layer view", isOn:
                            Binding(
                                get: {getVal(forKey: .useCustomErrorLayerView)},
                                set: {selected,_ in store(val: selected, key: .useCustomErrorLayerView) }
                            )
                    )
                    
                    Toggle("Use custom loading layer view", isOn:
                            Binding(
                                get: {getVal(forKey: .useCustomLoadingLayerView)},
                                set: {selected,_ in store(val: selected, key: .useCustomLoadingLayerView) }
                            )
                    )
                    
                    Toggle("Use custom complete layer view", isOn:
                            Binding(
                                get: {getVal(forKey: .useCustomCompleteLayerView)},
                                set: {selected,_ in store(val: selected, key: .useCustomCompleteLayerView) }
                            )
                    )
                }
                .tint(Color.indigo)
                
                Section(header: Text("Playback Controls Configuration")) {
                    Toggle("Hide Control Layer", isOn:
                            Binding(
                                get: {getVal(forKey: .hideControls)},
                                set: {selected,_ in store(val: selected, key: .hideControls) }
                            )
                    )
                    
                    Toggle("Hide Slider", isOn:
                            Binding(
                                get: {getVal(forKey: .hideSlider)},
                                set: {selected,_ in store(val: selected, key: .hideSlider) }
                            )
                    )
                    
                    Toggle("Hide Play Pause Toggle", isOn:
                            Binding(
                                get: {getVal(forKey: .hidePlayPauseToggle)},
                                set: {selected,_ in store(val: selected, key: .hidePlayPauseToggle) }
                            )
                    )
                    
                    Toggle("Hide Title", isOn:
                            Binding(
                                get: {getVal(forKey: .hideTitle)},
                                set: {selected,_ in store(val: selected, key: .hideTitle) }
                            )
                    )
                    
                    Toggle("Hide Picture in Picture", isOn:
                            Binding(
                                get: {getVal(forKey: .hidePictureInPicture)},
                                set: {selected,_ in store(val: selected, key: .hidePictureInPicture) }
                            )
                    )
                    
                    Toggle("Hide Settings Menu", isOn:
                            Binding(
                                get: {getVal(forKey: .hideSettingsMenu)},
                                set: {selected,_ in store(val: selected, key: .hideSettingsMenu) }
                            )
                    )
                    
                    Toggle("Hide Fullscreen Toggle", isOn:
                            Binding(
                                get: {getVal(forKey: .hideFullscreenToggle)},
                                set: {selected,_ in store(val: selected, key: .hideFullscreenToggle) }
                            )
                    )
                    
                    Toggle("Hide Remote Playback", isOn:
                            Binding(
                                get: {getVal(forKey: .hideRemotePlayback)},
                                set: {selected,_ in store(val: selected, key: .hideRemotePlayback) }
                            )
                    )
                }
                .tint(Color.pink)
            }
            .onAppear {
                selectedStreamState = StreamSource(rawValue:getString(forKey: .selectedStream)) ?? .invalid
            }
            .navigationTitle("Video Player settings")
            .navigationBarTitleDisplayMode(.large)
            .font(Font.system(size: 13, weight: .regular))
            
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
                
                ContentView(settings: sRAVPlayerSettingsModel, demoSettings: demoSettings,  customUISettings: customLayerSettings, streamUrl: selectedStreamState.url)
            }
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
