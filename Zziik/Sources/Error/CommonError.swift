//
//  CommonError.swift
//  Zziik
//
//  Created by 구태호 on 12/29/24.
//

import Foundation

enum CommonError: Error {
    case invalidURL
    case appOpenError
    case safariOpenError
    case message(msg: String)
}

extension CommonError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("URL 형식을 다시 확인해주세요", comment: "invalidURL error")
        case .message(let msg):
            return NSLocalizedString("\(msg)", comment: "errorMessage(\(msg)) error")
        case .appOpenError:
            return NSLocalizedString("앱을 열지 못했어요", comment: "appOpenError error")
        case .safariOpenError:
            return NSLocalizedString("잘못된 URL 입니다", comment: "safariOpenError error")
        }
    }
}
