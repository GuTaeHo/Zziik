//
//  View+.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

import SwiftUI

extension View {
    var className: String {
        String(describing: self)
    }
    
    static var className: String {
        String(describing: self)
    }
}
