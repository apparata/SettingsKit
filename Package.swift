// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "SettingsKit",
    platforms: [
        // Relevant platforms.
        .iOS(.v14), .macOS(.v11), .tvOS(.v14)
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
