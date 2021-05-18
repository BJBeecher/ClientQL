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
    dependencies: [
        .package(name: "RequestSocket", url: "https://github.com/BJBeecher/RequestSocket.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "ClientQL",
            dependencies: ["RequestSocket"]),
        .testTarget(
            name: "ClientQLTests",
            dependencies: ["ClientQL"]),
    ]
)
