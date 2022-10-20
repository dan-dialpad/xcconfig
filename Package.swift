// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "XCConfig",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .macCatalyst(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "XCConfig",
            targets: [
                "XCConfig"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XCConfig",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "XCConfigTests",
            dependencies: [
                "XCConfig"
            ],
            path: "Tests"
        ),
    ]
)
