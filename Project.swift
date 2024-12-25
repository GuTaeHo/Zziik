import ProjectDescription

let bundleID = "com.example.Zziik"

let deploymentTargets = DeploymentTargets.iOS("16.0")

let fonts = [
    "Pretendard-Bold.otf",
    "Pretendard-Medium.otf",
    "Pretendard-SemiBold.otf",
    "Pretendard-Regular.otf",
]

let infoPlist: [String: Plist.Value] = [
    // 폰트 추가
    "Fonts provided by application": .array(fonts.map { .string($0) }),
    // 런치 스크린
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    // 씬 델리게이트
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ],
            ]
        ]
    ],
]

let dependencies: [TargetDependency] = [
    .external(name: "Moya"),
    .external(name: "SnapKit"),
    .external(name: "Then"),
]

let project = Project(
    name: "Zziik",
    targets: [
        .target(
            name: "Zziik",
            destinations: .iOS,
            product: .app,
            bundleId: bundleID,
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Zziik/Sources/**"],
            resources: [.glob(pattern: "Zziik/Resources/**")],
            dependencies: dependencies,
            settings: .settings(base: [
                "CODE_SIGN_STYLE": "Automatic", // 자동 서명
                "DEVELOPMENT_TEAM": "L8WFLHVUYX" // Apple Developer Team ID
            ])
        ),
        .target(
            name: "ZziikTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleID)Tests",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["Zziik/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Zziik")],
            settings: .settings(base: [
                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "L8WFLHVUYX"
            ])
        ),
    ]
)
