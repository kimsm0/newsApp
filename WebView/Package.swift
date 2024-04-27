// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebView",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "WebView",
            targets: ["WebView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0)),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: .init(5, 7, 1)),
        .package(path: "../Platform"),
    ],
    targets: [
        .target(
            name: "WebView",
            dependencies: [
                "ModernRIBs",
                "Then",
                "SnapKit",                    
                .product(name: "Extensions", package: "Platform"),
                .product(name: "Common", package: "Platform"),
            ]
        ),
    ]
)
