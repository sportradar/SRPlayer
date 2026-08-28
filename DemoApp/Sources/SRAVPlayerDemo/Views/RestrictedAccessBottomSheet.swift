//
//  RestrictedAccessBottomSheet.swift
//  SRAVPlayerDemo
//

import SwiftUI

enum RestrictedAccessSheet: Identifiable, Sendable {
    case login
    case register

    var id: Self { self }

    var title: String {
        switch self {
        case .login: "Log In"
        case .register: "Register"
        }
    }
}

struct RestrictedAccessBottomSheet: View {
    let sheet: RestrictedAccessSheet

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Demo \(sheet.title) screen")
                    .font(.headline)

                Text("Integrate your authentication flow here.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle(sheet.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
