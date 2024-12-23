//
//  LoginView.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI
import Then

struct LoginView: View {
    @State private var id: String = ""
    @State private var pw: String = ""
    @State private var isLoginEnabled: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(.imgLogo92)
                    Text("기다림이 설렘으로 \n바뀌는 순간")
                        .font(.custom(.regular400, size: 30))
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Image(.imgDeliveryBox145)
                    }.padding(.top, 92)
                    
                    VStack(spacing: 30) {
                        UnderlineTextField(placeholder: "이메일 입력", text: $id)
                        UnderlineTextField(placeholder: "비밀번호 입력", text: $pw)
                    }.padding(.top, 18.0)
                    
                    CommonButton(title: "로그인")
                        .offset(x: 0, y: 30)
                }
            }
            .padding(.init(horizontal: 28, vertical: 80))
            .frame(width: geometry.size.width, alignment: .topLeading)
        }
    }
}

#Preview {
    LoginView()
}
