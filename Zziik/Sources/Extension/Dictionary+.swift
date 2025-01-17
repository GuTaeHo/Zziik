//
//  Dictionary+.swift
//  zziik
//
//  Created by 구태호 on 7/17/24.
//

import Foundation


extension Dictionary where Key == String, Value == Any {
    /// 딕셔너리를 `T` 형태로 객체화
    /// - Parameter type: 객체의 메타타입
    func toObject<T: Codable>(with type: T.Type) throws -> T {
        let dataizedDictionary = try JSONSerialization.data(withJSONObject: self)
        let objects = try JSONDecoder().decode(T.self, from: dataizedDictionary)
        return objects
    }
}
