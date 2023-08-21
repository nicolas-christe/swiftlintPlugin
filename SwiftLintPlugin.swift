import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        // get the config on the root if the target directory
        return [try .SwiftLint(
            tool: try context.tool(named: "swiftlint"),
            outputDir: context.pluginWorkDirectory,
            targetFiles: [target.directory.string])]
    }
}


#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftLintPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        return [try .SwiftLint(
            tool: try context.tool(named: "swiftlint"),
            outputDir: context.pluginWorkDirectory,
            targetFiles: target.inputFiles.map(\.path.string).filter { $0.hasSuffix(".swift") })]
    }
}
#endif

private extension Command {
    static func SwiftLint(tool: PackagePlugin.PluginContext.Tool, outputDir: PackagePlugin.Path,
                          targetFiles: [String]) throws-> Command {
        // generate configuration
        let toolDir = outputDir.removingLastComponent().appending("SwiftLintPlugin-config")
        try FileManager.default.createDirectory(atPath: toolDir.string, withIntermediateDirectories: true)
        let configPath = toolDir.appending("swiftlist.yml").string
        try config.write(toFile: configPath, atomically: true, encoding: .utf8)

        var arguments = [
            "lint",
            "--cache-path", "\(outputDir)",
            "--config", "\(configPath)",
        ]
        arguments.append(contentsOf: targetFiles)

        return .prebuildCommand(
            displayName: "swiftLint \(targetFiles)",
            executable: tool.path,
            arguments: arguments,
            // We are not producing output files and this is needed only to not include cache files into bundle
            outputFilesDirectory: outputDir.appending("Output")
        )
    }
}
