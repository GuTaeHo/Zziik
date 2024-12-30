//
//  AttributedString+.swift
//  blossom
//
//  Created by 구태호 on 12/28/23.
//

import UIKit

extension AttributedString {
    /// 속성이 지정된 문자열을 반환합니다.
    static func styledText(_ text: String, fontType: UIFont.FontType, fontSize: CGFloat, fontColor: UIColor = .init(resource: .ffffff), textAlignment: NSTextAlignment = .left) -> AttributedString {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        
        let attr: [NSAttributedString.Key : Any] = [
            .font: UIFont.font(type: fontType, size: fontSize),
            .foregroundColor: fontColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let attrStr = NSAttributedString(string: text, attributes: attr)
        
        return AttributedString(attrStr)
    }
    
    var toMutable: NSMutableAttributedString {
        return NSMutableAttributedString(self)
    }
}
