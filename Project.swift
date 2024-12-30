import ProjectDescription

let bundleID = "com.halftime.zziik"

let deploymentTargets = DeploymentTargets.iOS("16.0")

let fonts = [
    "Pretendard-Bold.otf",
    "Pretendard-Medium.otf",
    "Pretendard-SemiBold.otf",
    "Pretendard-Regular.otf",
]

let infoPlist: [String: Plist.Value] = [
    "CFBundleDisplayName": "Zziik",
    "CFBundleShortVersionString": "0.0.1",  // 엡 버전
    "CFBundleVersion": "1", // 빌드 번호
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
    "UIBackgroundModes": [
        "remote-notification",
    ],
]

let dependencies: [TargetDependency] = [
    .external(name: "Moya"),
    .external(name: "SnapKit"),
    .external(name: "Then"),
    .external(name: "KakaoSDKCommon"),
    .external(name: "KakaoSDKAuth"),
    .external(name: "KakaoSDKUser"),
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
            entitlements: .file(path: "Zziik/Zziik.entitlements"),
            dependencies: dependencies,
            settings: .settings(base: [
                "CODE_SIGN_STYLE": "Automatic", // 자동 서명
                "DEVELOPMENT_TEAM": "3MDWMG7Z69" // Apple Developer Team ID
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
                "DEVELOPMENT_TEAM": "3MDWMG7Z69"
            ])
        ),
    ]
)
