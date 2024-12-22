//
//  LoginView.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI
import Then

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(.imgLogo92)
            Text("기다림이 설렘으로 \n바뀌는 순간")
                .font(.custom(.regular, size: 30))
        }
    }
}

#Preview {
    LoginView()
}
