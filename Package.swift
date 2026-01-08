// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "git@gitlab.sportradar.ag:MobileApps/avplayer/av-player-data-sdk-spm.git"
let coreSDKVersion : Version = "0.1.0-DEV.400"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.0/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "8ee6094290f8fb17496c647a9cc800bdfbc0a722015c0b760bc3ce738e9c164d"

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

