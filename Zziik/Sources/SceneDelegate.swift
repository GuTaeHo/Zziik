//
//  SceneDelegate.swift
//  Zziik
//
//  Created by 구태호 on 12/18/24.
//

import UIKit
import SwiftUI
 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
 
        let loginView = LoginView()
        let hostingVC = UIHostingController(rootView: loginView)
        let viewController = UIViewController().then {
            $0.addChild(hostingVC)
            $0.view.addSubview(hostingVC.view)
            hostingVC.didMove(toParent: $0)
            $0.view.backgroundColor = .orange
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
