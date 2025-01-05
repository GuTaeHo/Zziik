//
//  RegExpUtil.swift
//  blossom
//
//  Created by 구태호 on 2022/08/25.
//

import Foundation


class RegExpUtil {
    enum RegCase {
        case email
        case password
        case birthday
        
        var predicate: String {
            switch self {
            case .email:
                return "[A-Z0-9a-z._%+-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,3}"
            case .password:
                return "^(?=.*[A-Za-z])(?=.*[0-9]).{8,15}"
            case .birthday:
                return "^(\\d{4})(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])$"
            }
        }
    }
    
    public static func evaluate(type case: RegCase, compareWith value: String) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", `case`.predicate)
        
        if pred.evaluate(with: value) {
            // 생년월일은 정확한 비교를 위해 추가적으로 데이트포맷터 사용
            if `case` == .birthday {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                return dateFormatter.date(from: value) != nil
            }
            
            return true
        } else {
            return false
        }
    }
}
