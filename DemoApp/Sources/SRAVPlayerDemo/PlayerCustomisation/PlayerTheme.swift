//
//  PlayerTheme.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 04.11.25.
//

import SRAVPlayerSDK
import SwiftUI

struct PlayerTheme: SRAVPlayerTheme {
    
    let fonts = SRAVPlayerFonts(familyName: "Avenir Next Condensed")
    let colors = SRAVPlayerColors(
        iconButtonPrimaryColor: Color(.playerThemeTint),
        labelColor: Color(light: "#AAAAAA", dark: "#FFFFFF"),
        popupTextColor: Color(light: "#AAAAAA", dark: "#FFFFFF")
    )
    let images : SRAVPlayerImages
                                  
    init() {
        let controlLayerImages = SRAVPlayerImages.ControlLayer(play:Image(systemName:"play.circle"),
                                                               pause:Image(systemName:"pause.circle"),
                                                               pipOn:Image(systemName:"pip"),
                                                               pipOff:Image(systemName:"pip.fill"),
                                                               fullscreenEnter: Image(systemName:"rectangle.expand.diagonal"),
                                                               fullscreenExit: Image(systemName:"rectangle.compress.vertical"),
                                                               settings: Image(systemName:"gear")
                                                              )
        
        images = SRAVPlayerImages(controlLayer:controlLayerImages)
    }
}

