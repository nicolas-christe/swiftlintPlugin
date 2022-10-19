# SwiftLint

SwiftLint plugin and shared config.

To add to your SPM, add the following lines to your `Package.swift`:

In the `dependencies` section:
```
    .package(url: "https://github.com/nicolas-christe/swiftlint.git", .upToNextMajor(from: "1.0.0")),
```

in your targets:
```
    plugins: [.plugin(name: "swiftlint", package: "swiftlint")])
``` 

To update `swiftgen` binaries

Download the `artifactbundle.zip` from `https://github.com/realm/SwiftLint/releases/`. In the pluging package
directory run `swift package compute-checksum SwiftLintBinary-macos.artifactbundle.zip` to compute the checksum.
Then update the `binaryTarget` on the package file
