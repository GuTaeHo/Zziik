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
//        do {
//            try KeychainManager.shared.append(.kakaoNativeKey, value: "92558f4b53ef4b1692cabce8bb7e4711")
//        } catch (let error) {
//            
//        }
    }
    
    private func initKakaoSDK() {
        KakaoSDK.initSDK(appKey: InfoPlistManager.shared.kakaoNativeAppKey)
    }
}
