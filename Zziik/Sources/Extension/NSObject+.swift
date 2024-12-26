//
//  NSObject+.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
    
    static var className: String {
        return String(describing: Self.self)
    }
}
