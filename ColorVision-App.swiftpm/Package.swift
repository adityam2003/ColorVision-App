// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "ColorVision-App",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "ColorVision-App",
            targets: ["AppModule"],
            bundleIdentifier: "com.example.ColorVision",
            teamIdentifier: "WUZ7WCX8QM",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .dog),
            accentColor: .presetColor(.purple),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .camera(purposeString: "Camera access required by the app to label colors.")
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ],
    swiftLanguageVersions: [.version("6")]
)