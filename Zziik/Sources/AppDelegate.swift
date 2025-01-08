//
//  AppDelegate.swift
//  Zziik
//
//  Created by 구태호 on 12/18/24.
//

import UIKit
import KakaoSDKCommon
 
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        initKakaoSDK()
    }
    
    private func initKakaoSDK() {
        KakaoSDK.initSDK(appKey: InfoPlistManager.shared.kakaoNativeAppKey)
    }
}
