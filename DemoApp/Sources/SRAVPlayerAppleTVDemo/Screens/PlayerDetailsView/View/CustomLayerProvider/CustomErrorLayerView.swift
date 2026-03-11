//
//  CustomErrorLayerView.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct CustomErrorLayerView: View {
    @ObservedObject private var viewModel: SRAVOverlayLayerViewModel
    
    init(viewModel: SRAVOverlayLayerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.purple
            
            Text("Custom error screne created by client. Tap anywhere to dismiss this message.").font(.title).foregroundStyle(.white).multilineTextAlignment(.center)
        }
        .onTapGesture {
            withAnimation {
                viewModel.tapToRetryButtonPressed()
            }
        }
    }
}
