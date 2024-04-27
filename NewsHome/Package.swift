// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsHome",
    platforms: [.iOS(.v13)],
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
        .library(
            name: "NewsTestSupport",
            targets: ["NewsTestSupport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(url: "https://github.com/devxoul/Then", from: .init(3, 0, 0)),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: .init(5, 7, 1)),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: .init(7, 0, 0)),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: .init(1, 12, 0)),
        .package(path: "../Platform"),
        .package(path: "../WebView"),
    ],
    targets: [
        .target(
            name: "NewsMain",
            dependencies: [
                "ModernRIBs",
                "Then",
                "SnapKit",
                "NewsDataModel",
                "Kingfisher",
                "NewsDetail",
                .product(name: "Extensions", package: "Platform"),
                .product(name: "CustomUI", package: "Platform"),
            ]
        ),
        .target(
            name: "NewsDetail",
            dependencies: [
                "ModernRIBs",
                "Then",
                "SnapKit",
                "NewsDataModel",
                "Kingfisher",
                "NewsRepository",
                .product(name: "Extensions", package: "Platform"),
                .product(name: "CustomUI", package: "Platform"),
                .product(name: "WebView", package: "WebView"),
            ]
        ),
        .target(
            name: "NewsRepository",
            dependencies: [
                .product(name: "Extensions", package: "Platform"),
                .product(name: "Network", package: "Platform"),
                .product(name: "Utils", package: "Platform"), 
                .product(name: "Common", package: "Platform"),
                .product(name: "CustomUI", package: "Platform"),                
                "NewsDataModel",
            ]
        ),
        .target(
            name: "NewsDataModel",
            dependencies: [
            ]
        ),
        .target(
            name: "NewsTestSupport",
            dependencies: [
                "NewsRepository",
                .product(name: "Extensions", package: "Platform"),
            ]
        ),
        .testTarget(name: "NewsMainTest",
                   dependencies: [
                    .product(name: "Extensions", package: "Platform"),
                    .product(name: "Network", package: "Platform"),
                    .product(name: "Utils", package: "Platform"),
                    .product(name: "Common", package: "Platform"),
                    .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                    "NewsDataModel",
                    "NewsRepository",
                    "NewsTestSupport",
                    "NewsMain",
                    
                   ],
                    exclude: [
                        "__Snapshots__",
                    ]),
        .testTarget(name: "NewsDetailTest",
                   dependencies: [
                    .product(name: "Extensions", package: "Platform"),
                    .product(name: "Network", package: "Platform"),
                    .product(name: "Utils", package: "Platform"),
                    .product(name: "Common", package: "Platform"),
                    .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                    .product(name: "WebView", package: "WebView"),
                    "NewsDataModel",
                    "NewsRepository",
                    "NewsTestSupport",
                    "NewsDetail",
                   ],
                    exclude: [
                        "__Snapshots__",
                    ])
    ]
)
    
