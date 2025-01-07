//
//  InfoPlistManager.swift
//  Zziik
//
//  Created by 구태호 on 1/7/25.
//

import Foundation


class InfoPlistManager {
    static let shared = InfoPlistManager()
    
    var appBundleID: String { Bundle.main.bundleIdentifier ?? "" }
    
    var appName: String { Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "" }
    
    var appVersion: String { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
    
    var appBuildNumber: String { Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "" }
    
    private init() { }
}
