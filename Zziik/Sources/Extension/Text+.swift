//
//  Text+.swift
//  Zziik
//
//  Created by 구태호 on 12/30/24.
//

import SwiftUI
import UIKit


extension Text {
    
}

extension UILabel {
    func font(type: UIFont.FontType = .regular400, size: CGFloat, color: UIColor?) {
        self.font = UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        
        if let color = color {
            self.textColor = color
        }
    }
}
