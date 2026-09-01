// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "https://github.com/sportradar/SRPlayer-SDK-Core"
let coreSDKVersion : Version = "0.3.49"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "31960fa5f2dbd6291893acbbde17a3df96cf24dd1039ca95434cb8b8616c41aa"

let chromecastSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerChromecastPlugin.xcframework.zip"
let chromecastSDKChecksum = "eab5c8b01c11fe62d7bac679b0f055928bf744afcbbb589b6962bd762f96647d"

let googleCastUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/GoogleCast.xcframework.zip"
let googleCastChecksum = "80dba38046ae1c048099b4d99a2e2288119230471934c0dc62a4db075dc8d02b"

let npawSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerNPAWPlugin.xcframework.zip"
let npawSDKChecksum = "0de409f4cbbf1ead2bb32dd61fc3463341d868a5a9bb7b39a7b9b29537f3bf20"

let npawPackageUrl = "https://bitbucket.org/npaw/plugin-ios.git"
let npawPackageName = "plugin-ios"
let npawPackageVersion : Version = "7.3.29"

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
        .library(
            name: "SRAVPlayerNPAWPlugin",
            targets: ["SRAVPlayerNPAWTarget"]
        ),
    ],
    dependencies: [
        .package(url: coreSDKUrl, exact:coreSDKVersion),
        .package(url: npawPackageUrl, exact: npawPackageVersion),
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
        .binaryTarget(
            name: "SRAVPlayerNPAWPlugin",
            url: npawSDKUrl,
            checksum: npawSDKChecksum
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
        ),
        .target(
            name: "SRAVPlayerNPAWTarget",
            dependencies: [
                // TODO: drop .when(platforms: [.iOS]) once build_framework.sh / project_template.yml emit macOS, tvOS, visionOS slices
                .target(name: "SRAVPlayerNPAWPlugin", condition: .when(platforms: [.iOS])),
                .product(name: "NpawPlugin", package: npawPackageName, condition: .when(platforms: [.iOS])),
                .target(name: "SRAVPlayerTarget"),
            ],
            path: "Sources/SRAVPlayerNPAWTarget"
        )
    ]
)
