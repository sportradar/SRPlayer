// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "git@gitlab.sportradar.ag:MobileApps/avplayer/av-player-data-sdk-spm.git"
let coreSDKVersion : Version = "0.1.0-DEV.400"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/v0.0.5/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "68d4660fdbf778be31ce442ba8d1ec4c98eadf294366cfe6d6e7eb4f90e3ef1a"

let package = Package(
    name: "SRAVPlayerSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .tvOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SRAVPlayerSDK",
            targets: ["SRAVPlayerTarget"]
        ),
    ],
    dependencies: [
        .package(url: coreSDKUrl, exact:coreSDKVersion)
    ],
    targets: [
        .binaryTarget(
            name: "SRAVPlayerSDK",
            url: nativeSDKUrl,
            checksum: nativeSDKChecksum
        ),
        .target(
            name: "SRAVPlayerTarget",
            dependencies: [
                .target(name: "SRAVPlayerSDK"),
                .product(name: "AVPlayerDataSDK", package: "av-player-data-sdk-spm"),
            ],
            path: "Sources/SRAVPlayerTarget",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        )
    ]
)

