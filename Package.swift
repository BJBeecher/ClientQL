// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClientQL",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ClientQL",
            targets: ["ClientQL"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ClientQL",
            dependencies: []),
        .testTarget(
            name: "ClientQLTests",
            dependencies: ["ClientQL"]),
    ]
)
