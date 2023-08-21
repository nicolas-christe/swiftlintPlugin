// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "SwiftLintPlugin",
  products: [
    .plugin(name: "SwiftLintPlugin", targets: ["SwiftLintPlugin"]),
  ],
  dependencies: [],
  targets: [
    .plugin(
      name: "SwiftLintPlugin",
      capability: .buildTool(),
      dependencies: ["SwiftLintBinary"],
      path: "."
    ),
    .binaryTarget(
      name: "SwiftLintBinary",
      url: "https://github.com/realm/SwiftLint/releases/download/0.52.4/SwiftLintBinary-macos.artifactbundle.zip",
      checksum: "8a8095e6235a07d00f34a9e500e7568b359f6f66a249f36d12cd846017a8c6f5"
    )
  ]
)
