//
//  CommonAlert.swift
//  Zziik
//
//  Created by 구태호 on 12/30/24.
//

import SwiftUI

class CommonAlert: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var error: CommonError?
}
