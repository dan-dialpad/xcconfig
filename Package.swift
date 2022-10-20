// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "XCConfig",
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
            dependencies: []
        ),
        .testTarget(
            name: "XCConfigTests",
            dependencies: [
                "XCConfig"
            ]
        ),
    ]
)
