//
//  Font+.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI
import UIKit



extension Font {
    enum FontType: String {
        case regular400 = "Pretendard-Regular"
        case medium500 = "Pretendard-Medium"
        case semiBold600 = "Pretendard-SemiBold"
        case bold700 = "Pretendard-Bold"
    }
    
    /// 프로젝트 폰트
    static func custom(_ type: Font.FontType, size: CGFloat) -> Font {
        return .custom(type.rawValue, fixedSize: size)
    }
}

extension UIFont {
    enum FontType: String {
        case regular400 = "Pretendard-Regular"
        case medium500 = "Pretendard-Medium"
        case semiBold600 = "Pretendard-SemiBold"
        case bold700 = "Pretendard-Bold"
    }
    
    /// 폰트 반환
    /// - Note: 폰트를 찾을 수 없는 경우 시스템 폰트 반환
    static func font(type: UIFont.FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
