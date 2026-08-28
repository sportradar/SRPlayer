// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "https://github.com/sportradar/SRPlayer-SDK-Core"
let coreSDKVersion : Version = "0.3.49"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "68e1b7493cff2bc43790050fd7c728787efd0ce9c530b8e178a3fb093913efb2"

let chromecastSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerChromecastPlugin.xcframework.zip"
let chromecastSDKChecksum = "edaf6165677fb1c214b18041a3b569df633d318d1f4a4701cbd08268a2fe5309"

let googleCastUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/GoogleCast.xcframework.zip"
let googleCastChecksum = "9a3c29411fd0d6030a1e218652b49331cfd91ee5d22da5edb13cd9dd87ac224d"

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
        .library(
            name: "SRAVPlayerChromecastPlugin",
            targets: ["SRAVPlayerChromecastTarget"]
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
        .binaryTarget(
            name: "SRAVPlayerChromecastPlugin",
            url: chromecastSDKUrl,
            checksum: chromecastSDKChecksum
        ),
        .binaryTarget(
            name: "GoogleCast",
            url: googleCastUrl,
            checksum: googleCastChecksum
        ),
        .target(
            name: "SRAVPlayerTarget",
            dependencies: [
                .target(name: "SRAVPlayerSDK"),
                .product(name: "AVPlayerOTTDataSDK", package: "SRPlayer-SDK-Core"),
            ],
            path: "Sources/SRAVPlayerTarget"
        ),
        .target(
            name: "SRAVPlayerChromecastTarget",
            dependencies: [
                .target(name: "SRAVPlayerChromecastPlugin", condition: .when(platforms: [.iOS])),
                .target(name: "GoogleCast", condition: .when(platforms: [.iOS])),
                .target(name: "SRAVPlayerTarget"),
            ],
            path: "Sources/SRAVPlayerChromecastTarget"
        )
    ]
)
