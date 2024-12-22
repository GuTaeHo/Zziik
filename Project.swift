import ProjectDescription

let deploymentTargets = DeploymentTargets.iOS("15.0")

let project = Project(
    name: "Zziik",
    targets: [
        .target(
            name: "Zziik",
            destinations: .iOS,
            product: .app,
            bundleId: "com.example.Zziik",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
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
            ),
            sources: ["Zziik/Sources/**"],
            resources: ["Zziik/Resources/**"],
            dependencies: [
                .external(name: "Moya"),
                .external(name: "SnapKit"),
                .external(name: "Then"),
            ],
            settings: .settings(base: [
                "CODE_SIGN_STYLE": "Automatic", // 자동 서명
                "DEVELOPMENT_TEAM": "L8WFLHVUYX" // Apple Developer Team ID
            ])
        ),
        .target(
            name: "ZziikTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.example.ZziikTests",
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
