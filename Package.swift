// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "git@gitlab.sportradar.ag:MobileApps/avplayer/av-player-data-sdk-spm.git"
let coreSDKVersion : Version = "0.1.0-DEV.400"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/0.7.0/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "24637b5895917a2bc57c159f161738f264bc4676a3acab3507898568c7ff120d"

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

