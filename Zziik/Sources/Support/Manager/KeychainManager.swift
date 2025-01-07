//
//  KeychainManager.swift
//  Zziik
//
//  Created by 구태호 on 1/7/25.
//

import Foundation


enum KeychainError: LocalizedError {
    case appendFail
    case fetchFail
}

class KeychainManager {
    static let shared = KeychainManager()
    
    /// 키체인 식별 태그
    let tag = InfoPlistManager.shared.appBundleID
    
    enum Key: String {
        case kakaoNativeKey
        
        var secClass: CFString {
            switch self {
            case .kakaoNativeKey: return kSecClassKey
            }
        }
    }
    
    func append<T: Codable>(_ key: Key, value: T) throws {
        let data = try JSONEncoder().encode(value)
        
        let query: [CFString: Any] = [kSecClass: key.secClass,
                                      kSecAttrService: tag,
                                      kSecAttrAccount: key.rawValue,
                                      kSecValueData: data]
        
        if SecItemAdd(query as CFDictionary, nil) != errSecSuccess {
            throw KeychainError.appendFail
        }
    }
    
    func remove(_ key: Key) {
        
    }
    
    func replace<T: Codable>(_ key: Key, value: T) {
        
    }
    
    /// **key** 와 일치하는 모든 데이터를 배열로 반환
    func fetch<T: Codable>(_ key: Key) throws -> [T] {
        let query: [CFString: Any] = [kSecClass: key.secClass,
                                      kSecAttrService: tag,
                                      kSecAttrAccount: key.rawValue,
                                      kSecReturnData: true,
                                      kSecMatchLimit: kSecMatchLimitAll]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            return try JSONDecoder().decode([T].self, from: data)
        }
        
        throw KeychainError.fetchFail
    }
    
    private init() {
        
    }
}
