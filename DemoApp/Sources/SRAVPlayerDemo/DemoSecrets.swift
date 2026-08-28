//
//  DemoSecrets.public.swift
//  LocalDemoConfig — public-safe stub injected into GitHub DemoApp as DemoSecrets.swift
//
//  Same API as DemoSecrets.swift; empty / public-safe defaults only.
//

enum DemoSecrets {
    // MARK: - OTT auth headers

    static let authorizationToken = ""
    static let xAuthorizationToken = ""

    static var ottTokenHeaders: [String: String] {
        guard !authorizationToken.isEmpty else { return [:] }
        return [
            "authorization": authorizationToken,
            "xauthorization": xAuthorizationToken
        ]
    }

    // MARK: - Private streams (empty on public GitHub)

    static let privateStreams: [DemoStreamOption] = []

    // MARK: - Chromecast

    /// Default Custom Receiver (public-safe). Fill LocalDemoConfig for internal receivers.
    static let chromecastReceiverAppID = "DF1B7172"

    static let chromecastBonjourService = "_DF1B7172._googlecast._tcp"
}
