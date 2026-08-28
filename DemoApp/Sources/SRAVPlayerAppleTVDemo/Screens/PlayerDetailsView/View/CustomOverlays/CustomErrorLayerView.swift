//
//  CustomErrorLayerView.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 6. 1. 26.
//

import SwiftUI
import SRAVPlayerSDK

struct CustomErrorLayerView: View {
    private let coordinator : ErrorOverlayCoordinator
    private var data: ErrorOverlayData {
        coordinator.errorOverlayData
    }
    
    init(coordinator: ErrorOverlayCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            Color.purple
            
            Text("Custom error screne created by client. Tap anywhere to dismiss this message.").font(.title).foregroundStyle(.white).multilineTextAlignment(.center)
        }
        .onTapGesture {
            withAnimation {
                coordinator.onInteraction(.retry)
            }
        }
    }
}

#Preview {
    let data : ErrorOverlayData = .init(exception: nil, canRetry: true, canDismiss: true)
    CustomErrorLayerView(coordinator: .init(errorOverlayData: data, onInteraction: {_ in}))
}
