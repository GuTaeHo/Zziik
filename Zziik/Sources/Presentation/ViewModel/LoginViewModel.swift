//
//  LoginViewModel.swift
//  Zziik
//
//  Created by 구태호 on 1/21/25.
//

import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pw: String = ""
    @Published var isLoginEnable: Bool = false
    @Published var invalidReason: String = ""
    
    
    func validation(isShowAlert: Bool) {
        if id.isEmpty || pw.isEmpty {
            isLoginEnable = false
            if isShowAlert {
                invalidReason = "이메일 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요."
            } else {
                invalidReason = ""
            }
            return
        } else {
            isLoginEnable = true
            invalidReason = ""
        }
    }
}
