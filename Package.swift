// swift-tools-version:5.1

import PackageDescription

let package = Package.init(
    name: "GithubComment",
    platforms: [.macOS(SupportedPlatform.MacOSVersion.v10_13)],
    products: [
        .executable(name: "GithubComment", targets: [ "GithubComment" ])
    ],
    targets: [
        .target(name: "GithubComment")
    ]
)
