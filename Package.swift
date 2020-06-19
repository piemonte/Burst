// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Burst",
    platforms: [
      .iOS(.v10)
    ],
    products: [
      .library(name: "Burst", targets: ["Burst"])
    ],
    targets: [
      .target(
          name: "Burst",
          path: "Sources"
      )
    ],
    swiftLanguageVersions: [.v5]
)
