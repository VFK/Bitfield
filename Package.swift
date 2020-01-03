// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bitfield",
    products: [
        .library(
            name: "Bitfield",
            targets: ["Bitfield"]),
    ],
    targets: [
        .target(
            name: "Bitfield",
            dependencies: []),
        .testTarget(
            name: "BitfieldTests",
            dependencies: ["Bitfield"]),
    ]
)
