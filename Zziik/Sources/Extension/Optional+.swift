//
//  Optional+.swift
//  Zziik
//
//  Created by 구태호 on 12/24/24.
//

import Foundation


extension Optional where Wrapped == String {
    /// String? 이 nil 일 경우 빈 문자열("") 반환
    var toEmptyIfOptional: String {
        switch self {
        case .some(let wrapped):
            return wrapped
            
        case .none:
            return ""
        }
    }
    
    /// 공백일 경우 nil 반환
    var toOptionalIfEmpty: String? {
        switch self {
        case .none:
            return nil
        case .some(let wrapped):
            return wrapped.isEmpty ? nil : wrapped
        }
    }
}
