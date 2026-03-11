//
//  DemoSettings.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import Foundation

struct DemoSettings {
    let themeComparison: Bool
    let forcePlayerError: Bool
    let autoplay: Bool
    
    init(themeComparison: Bool, forcePlayerError: Bool, autoplay: Bool) {
        self.themeComparison = themeComparison
        self.forcePlayerError = forcePlayerError
        self.autoplay = autoplay
    }
}
