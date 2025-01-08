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
        initKeychain()
    }
    
    private func initKakaoSDK() {
        KakaoSDK.initSDK(appKey: InfoPlistManager.shared.kakaoNativeAppKey)
    }
    
    private func initKeychain() {
        if (try? KeychainManager.shared.fetch(.kakaoNativeKey, type: String.self)) == nil {
            do {
                try KeychainManager.shared.append(.kakaoNativeKey, value: InfoPlistManager.shared.kakaoNativeAppKey)
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}
