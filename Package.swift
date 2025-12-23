// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "git@gitlab.sportradar.ag:MobileApps/avplayer/av-player-data-sdk-spm.git"
let coreSDKVersion : Version = "0.1.0-DEV.400"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/v0.0.2/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "fc55c22e18ef04913ecf418f45d0f2fa033ccaafa97c85a978d983babb4223be"

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
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        )
    ]
)

