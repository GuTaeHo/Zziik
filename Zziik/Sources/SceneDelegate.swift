//
//  SceneDelegate.swift
//  Zziik
//
//  Created by 구태호 on 12/18/24.
//

import UIKit
import SwiftUI
import SnapKit
 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        initLayout()
    }
    
    private func initLayout() {
        let loginView = LoginView()
        let hostingVC = UIHostingController(rootView: loginView)
        let viewController = UIViewController().then {
            $0.addChild(hostingVC)
            $0.view.addSubview(hostingVC.view)
            hostingVC.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            hostingVC.didMove(toParent: $0)
            $0.view.backgroundColor = .orange
        }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
