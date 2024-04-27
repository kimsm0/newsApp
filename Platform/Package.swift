// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Storage",
            targets: ["Storage"]),
        .library(
            name: "Common",
            targets: ["Common"]),
        .library(
            name: "CustomUI",
            targets: ["CustomUI"]),
        .library(
            name: "Extensions",
            targets: ["Extensions"]),
        
        .library(
            name: "Utils",
            targets: ["Utils"]),
        .library(
            name: "Network",
            targets: ["Network"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: .init(1, 0, 0)),
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0)),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: .init(5, 7, 1)),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: .init(1, 0, 0)),
    ],
    targets: [
        .target(
            name: "Storage"),
        .target(
            name: "Common",
            dependencies: [
                "Storage",
                "Extensions"
            ]
        ),
        .target(
            name: "CustomUI",
            dependencies: [
                "Then",
                "Extensions",
                "SnapKit"
            ]
        ),
        .target(
            name: "Extensions",
            dependencies: [
                "ModernRIBs"
            ]
        ),
        .target(
            name: "Utils",
            dependencies: [
                "CombineExt",
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]
        ),
        .target(
            name: "Network",
            dependencies: [
                "Common"
            ]
        ),
    ]
)
