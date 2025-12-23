// swift-tools-version: 6.2
import PackageDescription


let coreSDKPath = "git@gitlab.sportradar.ag:MobileApps/avplayer/av-player-data-sdk-spm.git"
let coreSDKVersion : Version = "0.1.0-DEV.400"

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
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SRAVPlayerSDK",
            targets: ["SRAVPlayerSDK"]),
    ],
    dependencies: [
        .package(url: coreSDKPath, exact:coreSDKVersion)
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SRAVPlayerSDK",
            dependencies: [
                .product(name: "AVPlayerDataSDK", package: "av-player-data-sdk-spm"),
            ],
            path: "SRAVPlayerSDK/Sources/SRAVPlayer",
            swiftSettings: [
                .defaultIsolation(MainActor.self) //https://www.avanderlee.com/concurrency/default-actor-isolation-in-swift-6-2/
            ]
        ),
        .testTarget(
            name: "SRAVPlayerTests",
            dependencies: ["SRAVPlayerSDK"],
            path: "SRAVPlayerSDK/Tests",
            swiftSettings: [
                .defaultIsolation(MainActor.self)
            ]
        ),
    ]
)
