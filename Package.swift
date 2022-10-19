// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "swiftlint",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .plugin(
            name: "swiftlint",
            targets: ["swiftlint"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.50.0-rc.2/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "c100354e0f6ea2531806df3199157e7e8a1eccb920d4da8e9a46f5f498aa4a6a"
        ),
        
        .plugin(
            name: "swiftlint",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"],
            path: "."),
    ]
)
