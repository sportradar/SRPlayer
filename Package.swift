// swift-tools-version: 6.2
import PackageDescription

let coreSDKUrl = "https://github.com/sportradar/SRPlayer-SDK-Core"
let coreSDKVersion : Version = "0.3.49"

let nativeSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerSDK.xcframework.zip"
let nativeSDKChecksum = "b2e359d1475c2d55940a50e219d0c9ed086b8a5740158016c9512bb7dc487353"

let chromecastSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerChromecastPlugin.xcframework.zip"
let chromecastSDKChecksum = "60fb3cd88fa46e7cff518522aadded8f311e8342e485c5ea46fb105957d139fc"

let googleCastUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/GoogleCast.xcframework.zip"
let googleCastChecksum = "9c797caa76694e42d836f2cbfa7f9dc22671f1dd5dea82120073bf0216b89b1c"

let npawSDKUrl = "https://github.com/sportradar/SRPlayer/releases/download/1.0.1/SRAVPlayerNPAWPlugin.xcframework.zip"
let npawSDKChecksum = "ecc9f9a20a10592070fd6d782f42be4ff060f70cb3b5668abf31b399bea74902"

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
