// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "https://github.com/sportradar/SRPlayer-SDK-Core"
let coreSDKVersion : Version = "0.1.0"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.0/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "d7a2c12c2b29995e036570ea943e540b24e583f42ee629d19d9b9df0addc9ebd"

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
                .product(name: "AVPlayerDataSDK", package: "SRPlayer-SDK-Core"),
            ],
            path: "Sources/SRAVPlayerTarget"
        )
    ]
)

