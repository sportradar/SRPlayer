//
//  StreamSource.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 10.12.25.
//

struct DemoStreamOption: Identifiable, Hashable {
    let id: String
    let title: String
    let url: String
    let isOTT: Bool
}

/// Public stream catalog only. Private / OTT / signed streams come from `DemoSecrets.privateStreams`.
enum StreamSource {
    static let publicStreams: [DemoStreamOption] = [
        DemoStreamOption(
            id: "elephantsDream",
            title: "Elephants Dream",
            url: "https://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8",
            isOTT: false
        ),
        DemoStreamOption(
            id: "elephantsDream2",
            title: "Elephants Dream 2",
            url: "https://d2zihajmogu5jn.cloudfront.net/elephantsdream/hls/ed_hd.m3u8",
            isOTT: false
        ),
        DemoStreamOption(
            id: "tearsOfSteel",
            title: "Tears of Steel",
            url: "https://bitmovin-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
            isOTT: false
        ),
        DemoStreamOption(
            id: "tearsOfSteel2",
            title: "Tears of Steel 2",
            url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8",
            isOTT: false
        ),
        DemoStreamOption(
            id: "invalid",
            title: "Invalid Stream",
            url: "https://invalid.url/playlist.m3u8",
            isOTT: false
        )
    ]

    static var allStreams: [DemoStreamOption] {
        publicStreams + DemoSecrets.privateStreams
    }

    static func stream(id: String) -> DemoStreamOption? {
        allStreams.first { $0.id == id }
    }

    static var defaultStream: DemoStreamOption {
        publicStreams.first { $0.id == "elephantsDream" }
            ?? publicStreams.first { $0.id == "invalid" }
            ?? publicStreams[0]
    }
}
