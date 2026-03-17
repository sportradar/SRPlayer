// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "https://github.com/sportradar/SRPlayer-SDK-Core"
let coreSDKVersion : Version = "0.2.0"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "ae0e543bd41dee96091d961824f84a2e1b4bcd3f409c1f926d2f80c9a81f87a4"

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

