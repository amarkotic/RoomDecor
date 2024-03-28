// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VirtualObject",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "VirtualObject",
            targets: ["VirtualObject"])
    ],
    dependencies: [
        .package(name: "Core", path: "Core"),
        .package(name: "CoreUi", path: "CoreUi"),
        .package(url: "https://github.com/SnapKit/SnapKit", exact: "5.7.1")
    ],
    targets: [
        .target(
            name: "VirtualObject",
            dependencies: [
                "Core",
                "CoreUi",
                .product(name: "SnapKit", package: "SnapKit")
            ],
            resources: [
                .process("Resources/3DModels")
            ]),
        .testTarget(
            name: "VirtualObjectTests",
            dependencies: ["VirtualObject"])
    ]
)
