//
//  Font+.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI


extension Font {
    enum FontType: String {
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case bold = "Pretendard-Bold"
    }
    
    /// 프로젝트 폰트
    static func custom(_ type: Font.FontType, size: CGFloat) -> Font {
        return .custom(type.rawValue, fixedSize: size)
    }
}
