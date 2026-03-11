//
//  PickerStyleModifier.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 5. 1. 26.
//

import SwiftUI

struct PickerStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(tvOS 17.0, *) {
            content.pickerStyle(.menu)
        } else {
            content.pickerStyle(.automatic)
        }
    }
}

// MARK: (Public) - Picker style helper method.
extension View {
    func pickerStyleModifier() -> some View {
        modifier(PickerStyleModifier())
    }
}
