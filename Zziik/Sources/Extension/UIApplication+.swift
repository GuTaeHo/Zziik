//
//  UIApplication.swift
//  Zziik
//
//  Created by 구태호 on 12/29/24.
//

import UIKit


extension UIApplication {
    /// 현재 윈도우 반환
    var currentWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })
    }
}
