// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "SettingsKit",
    platforms: [
        // Relevant platforms.
        .iOS(.v17), .macOS(.v14), .tvOS(.v17), .visionOS(.v1)
    ],
    products: [
        .library(name: "SettingsKit", targets: ["SettingsKit"])
    ],
    dependencies: [
        // It's a good thing to keep things relatively
        // independent, but add any dependencies here.
    ],
    targets: [
        .target(
            name: "SettingsKit",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ])
    ]
)
