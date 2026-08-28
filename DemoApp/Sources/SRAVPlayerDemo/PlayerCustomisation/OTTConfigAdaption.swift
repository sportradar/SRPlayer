//
//  ConfigAdaption.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 04.05.26.
//
import SRAVPlayerSDK

//!!!: - needs to be nonisolated
nonisolated
class OTTConfigAdaption: ConfigAdaptationUseCase {
    func adaptConfig(config: OTTConfig) -> OTTConfig {
        return config
    }
    
    deinit {
        print("Deinit OTTConfigAdaption")
    }
}
