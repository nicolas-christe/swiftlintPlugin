import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PackagePlugin.PluginContext,
        target: PackagePlugin.Target
    ) async throws -> [PackagePlugin.Command] {
        [try buildCommand(tool: try context.tool(named: "swiftlint"), workingDirectory: context.pluginWorkDirectory,
                          targetFiles: [target.directory])]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftLintPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(
        context: XcodePluginContext,
        target: XcodeTarget
    ) throws -> [Command] {
        [try buildCommand(tool: try context.tool(named: "swiftlint"), workingDirectory: context.pluginWorkDirectory,
                          targetFiles:  target.inputFiles.map(\.path))]
    }
}
#endif

private func buildCommand(tool: PackagePlugin.PluginContext.Tool,
                          workingDirectory: PackagePlugin.Path,
                          targetFiles: [PackagePlugin.Path]) throws -> PackagePlugin.Command {
    // create config in the working directory
    let configFile = workingDirectory.appending("swiftlist.yml").string
    try config.write(toFile: configFile, atomically: true, encoding: .utf8)
    // create build command
    return .buildCommand(
        displayName: "SwiftLint", executable: tool.path,
        arguments: [
            "lint",
            "--cache-path", "\(workingDirectory)",
            "--config", "\(configFile)",
            "\(targetFiles).joined(separator: ", ")"
        ]
    )
}
