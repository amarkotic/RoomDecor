// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUi",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CoreUi",
            targets: ["CoreUi"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", exact: "5.7.1")
    ],
    targets: [
        .target(
            name: "CoreUi",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit")
            ]),
        .testTarget(
            name: "CoreUiTests",
            dependencies: ["CoreUi"])
    ]
)
