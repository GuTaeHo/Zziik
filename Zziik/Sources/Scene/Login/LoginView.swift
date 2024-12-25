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
    @FocusState private var idFocus: Bool
    @State private var pw: String = ""
    @FocusState private var pwFocus: Bool
    @State private var isLoginEnabled: Bool = false
    @State private var invalidReason: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView {
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
                                    .submitLabel(.next)
                                    .focused($idFocus)
                                    .onAppear {
//                                        idFocus = true
                                        withAnimation {
                                            proxy.scrollTo("idTextField", anchor: .bottom)
                                        }
                                    }
                                    .onSubmit {
                                        pwFocus = true
                                        withAnimation {
                                            proxy.scrollTo("pwTextField", anchor: .bottom)
                                        }
                                    }
                                    .onChange(of: id) { _ in
                                        validation()
                                    }
                                    .id("idTextField")
                                UnderlinePasswordTextField(placeholder: "비밀번호 입력", text: $pw)
                                    .submitLabel(.done)
                                    .focused($pwFocus)
                                    .onChange(of: id) { _ in
                                        validation()
                                    }
                                    .id("pwTextField")
                                
                            }.padding(.top, 18.0)
                            
                            if invalidReason.isEmpty == false {
                                HStack {
                                    Text(invalidReason)
                                        .font(.custom(.regular400, size: 13))
                                        .foregroundStyle(Color.init(.E_90202))
                                    Spacer()
                                }.offset(y: 12)
                            }
                            
                            VStack(spacing: 16) {
                                CommonButton(title: "로그인", isEnabled: $isLoginEnabled) {
                                    
                                }
                                
                                HStack {
                                    Button("회원가입") { }
                                        .padding(8)
                                        .foregroundStyle(Color.init(._212121))
                                        .font(.custom(.regular400, size: 14))
                                    Divider()
                                        .background(Color.init(.DCDCDC))
                                        .frame(width: 1, height: 10)
                                    Button("아이디 찾기") { }
                                        .padding(8)
                                        .foregroundStyle(Color.init(._212121))
                                        .font(.custom(.regular400, size: 14))
                                    Divider()
                                        .background(Color.init(.DCDCDC))
                                        .frame(width: 1, height: 10)
                                    Button("비밀번호 찾기") { }
                                        .padding(8)
                                        .foregroundStyle(Color.init(._212121))
                                        .font(.custom(.regular400, size: 14))
                                }
                            }.offset(x: 0, y: 30)
                        }
                    }
                    .padding(.init(horizontal: 28, vertical: 80))
                    .frame(width: geometry.size.width)
                }
            }
            
            VStack(alignment: .leading) {
                Spacer()
                HStack(spacing: 14) {
                    Text("간편하게 시작하기")
                        .font(.custom(.regular400, size: 14))
                        .foregroundStyle(Color.init(._212121))
                    Spacer()
                    Button(action: { }) {
                        Circle()
                            .stroke(Color.init(.DCDCDC), lineWidth: 1)
                            .frame(width: 54, height: 54)
                            .overlay {
                                Image(.icGoogleLogo22)
                                    .frame(width: 22, height: 22)
                            }
                    }
                    .frame(width: 54, height: 54)
                    Button(action: { }) {
                        Circle()
                            .fill(.black)
                            .frame(width: 54, height: 54)
                            .overlay {
                                Image(.icAppleLogo22)
                                    .frame(width: 22, height: 22)
                            }
                    }
                    .frame(width: 54, height: 54)
                    Button(action: { }) {
                        Circle()
                            .fill(.yellow)
                            .frame(width: 54, height: 54)
                            .overlay {
                                Image(.icKakaoLogo22)
                                    .frame(width: 22, height: 22)
                            }
                    }
                    .frame(width: 54, height: 54)
                }
                .padding([.leading, .trailing], 26)
                .frame(maxWidth: .infinity, maxHeight: 86)
                .background(Color(.F_9_F_9_F_9))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
    
    func validation() {
        if id.isEmpty || pw.isEmpty {
            invalidReason = "이메일 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요."
            isLoginEnabled = false
            return
        }
        
        invalidReason = ""
        isLoginEnabled = true
    }
}

#Preview {
    LoginView()
}
