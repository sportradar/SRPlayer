//
//  OTTTokenHeaderUseCase.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 04.05.26.
//

import SRAVPlayerSDK

/// Demo `TokenHeaderUseCase`. Tokens come from `LocalDemoConfig/DemoSecrets` (GitLab)
/// or the public stub injected for GitHub DemoApp releases.
class OTTTokenHeaderUseCase: TokenHeaderUseCase {
    func __invoke(purpose: AVPlayerOTTDataSDK.TokenPurpose) async throws -> [String: String] {
        DemoSecrets.ottTokenHeaders
    }
}
