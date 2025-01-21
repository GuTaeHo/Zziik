//
//  CommonAlert.swift
//  Zziik
//
//  Created by 구태호 on 12/30/24.
//

import SwiftUI

class CommonAlert: ObservableObject {
    @Published var isShowing: Bool
    @Published var error: CommonError
    
    init(isShowing: Bool, error: CommonError = .message(msg: "에러 없음")) {
        self.isShowing = isShowing
        self.error = error
    }
}
