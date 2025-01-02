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
        KakaoSDK.initSDK(appKey: "92558f4b53ef4b1692cabce8bb7e4711")
    }
}
