// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "git@gitlab.sportradar.ag:MobileApps/avplayer/av-player-data-sdk-spm.git"
let coreSDKVersion : Version = "0.1.0-DEV.400"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/v0.0.14/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "796eb225c7b47ec6e7db0a8820f675a5bc10accec78f433660e7e874aa93ff0b"

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
            path: "Sources/SRAVPlayerTarget"
        )
    ]
)

