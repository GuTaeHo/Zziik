// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "Moya": .framework,
            "SnapKit": .framework,
            "Then": .framework,
        ]
    )
#endif

let package = Package(
    name: "Zziik",
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "3.0.0"))
    ]
)
