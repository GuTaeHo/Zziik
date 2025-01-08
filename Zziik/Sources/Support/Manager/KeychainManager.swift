//
//  KeychainManager.swift
//  Zziik
//
//  Created by 구태호 on 1/7/25.
//

import Foundation


enum KeychainError: LocalizedError {
    case appendFail(reason: String)
    case fetchFail(reason: String)
}

class KeychainManager {
    static let shared = KeychainManager()
    
    /// 키체인 식별 태그
    let tag = InfoPlistManager.shared.appBundleID
    
    enum Key: String {
        case kakaoNativeKey
        
        var secClass: CFString {
            switch self {
            case .kakaoNativeKey: return kSecClassGenericPassword
            }
        }
    }
    
    func append<T: Codable>(_ key: Key, value: T) throws {
        let data = try JSONEncoder().encode(value)
        
        let query: [String: Any] = [kSecClass as String: key.secClass,
                                      kSecAttrService as String: tag,
                                      kSecAttrAccount as String: key.rawValue,
                                      kSecValueData as String: data]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                throw KeychainError.appendFail(reason: error)
            } else {
                throw KeychainError.appendFail(reason: "알 수 없음")
            }
        }
    }
    
    func remove(_ key: Key) {
        
    }
    
    func replace<T: Codable>(_ key: Key, value: T) {
        
    }
    
    /// **key** 와 일치하는 모든 데이터를 배열로 반환
    func fetch<T: Codable>(_ key: Key, type: T.Type) throws -> [T] {
        let query: [CFString: Any] = [kSecClass: key.secClass,
                                      kSecAttrService: tag,
                                      kSecAttrAccount: key.rawValue,
                                      kSecReturnData: true,
                                      kSecMatchLimit: kSecMatchLimitAll]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            do {
                let jsonData = try JSONDecoder().decode([T].self, from: data)
                return jsonData
            } catch (let error) {
                throw error
            }
        } else {
            if let error: String = SecCopyErrorMessageString(status, nil) as String? {
                throw KeychainError.fetchFail(reason: error)
            } else {
                throw KeychainError.fetchFail(reason: "알 수 없음")
            }
        }
    }
    
    private init() {
        
    }
}
