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
    "UIAppFonts": .array(fonts.map { .string($0) }),
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
    // 앱 실행 허용 목록
    "LSApplicationQueriesSchemes": [
        // 카카오톡으로 로그인
        "kakaokompassauth",
        // 카카오톡 공유
        "kakaolink",
        // 카카오톡 채널
        "kakaoplus",
    ],
    // URL Scheme 지정
    "CFBundleURLTypes": [
        [
            "CFBundleURLSchemes": [
                "kakao92558f4b53ef4b1692cabce8bb7e4711",
            ]
        ]
    ],
    // 카카오 SDK 키 (.xcconfig 에 설정됨)
    "KAKAO_NATIVE_APP_KEY": "$(KAKAO_NATIVE_APP_KEY)",
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
            settings: .settings(
                base: [
                "CODE_SIGN_STYLE": "Automatic", // 자동 서명
                "DEVELOPMENT_TEAM": "3MDWMG7Z69" // Apple Developer Team ID
                ],
                configurations: [
                    .debug(name: "Debug", xcconfig: "Configs/Debug.xcconfig"),
                    .release(name: "Release", xcconfig: "Configs/Release.xcconfig")
                ]
            )
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
