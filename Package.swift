// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Burst",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "Burst", targets: ["Burst"])
    ],
    targets: [
        .target(
            name: "Burst",
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
