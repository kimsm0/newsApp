// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsHome",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "NewsMain",
            targets: ["NewsMain"]),
        .library(
            name: "NewsDetail",
            targets: ["NewsDetail"]),
        .library(
            name: "NewsRepository",
            targets: ["NewsRepository"]),
        .library(
            name: "NewsDataModel",
            targets: ["NewsDataModel"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0)),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: .init(5, 7, 1)),
        .package(path: "../Platform"),
    ],
    targets: [
        .target(
            name: "NewsMain",
            dependencies: [
                "ModernRIBs",
                "Then",
                "SnapKit",
                .product(name: "Extensions", package: "Platform"),
            ]
        ),
        .target(
            name: "NewsDetail",
            dependencies: [
                "ModernRIBs",
                "Then",
                "SnapKit",
                .product(name: "Extensions", package: "Platform"),
            ]
        ),
        .target(
            name: "NewsRepository",
            dependencies: [
                .product(name: "Extensions", package: "Platform"),
                .product(name: "Network", package: "Platform"),
                .product(name: "Utils", package: "Platform"), 
                "NewsDataModel"
            ]
        ),
        .target(
            name: "NewsDataModel",
            dependencies: [
            ]
        ),
    ]
)
