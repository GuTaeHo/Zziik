//
//  LoginView.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI
import Then
import AuthenticationServices


struct LoginView: View {
    @State private var id: String = ""
    @FocusState private var idFocus: Bool
    @State private var pw: String = ""
    @FocusState private var pwFocus: Bool
    @State private var isLoginEnabled: Bool = false
    @State private var invalidReason: String = ""
    
    @State private var path: [LoginNavigationType] = []
    
    @StateObject private var alert: CommonAlert = .init(isShowing: false)
    
    var body: some View {
        NavigationStack(path: $path) {
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
                                            validation(isShowAlert: false)
                                        }
                                        .id("idTextField")
                                    UnderlinePasswordTextField(placeholder: "비밀번호 입력", text: $pw)
                                        .submitLabel(.done)
                                        .focused($pwFocus)
                                        .onChange(of: pw) { _ in
                                            validation(isShowAlert: false)
                                        }
                                        .id("pwTextField")
                                    
                                }.padding(.top, 18.0)
                                
                                if invalidReason.isEmpty == false {
                                    HStack {
                                        Text(invalidReason)
                                            .font(.custom(.regular400, size: 13))
                                            .foregroundStyle(Color.init(.e90202))
                                        Spacer()
                                    }.offset(y: 12)
                                }
                                
                                VStack(spacing: 16) {
                                    CommonButton(title: "로그인", isEnabled: $isLoginEnabled) {
                                        validation(isShowAlert: true)
                                    }.onAppear {
                                        validation(isShowAlert: false)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        Button("회원가입") {
                                            path.append(.regist)
                                        }
                                        .padding(8)
                                        .foregroundStyle(Color(._212121))
                                        .font(.custom(.regular400, size: 14))
                                        Divider()
                                            .background(Color(.dcdcdc))
                                            .frame(width: 1, height: 10)
                                        Button("아이디 찾기") { }
                                            .padding(8)
                                            .foregroundStyle(Color.init(._212121))
                                            .font(.custom(.regular400, size: 14))
                                        Divider()
                                            .background(Color.init(.dcdcdc))
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
                                .stroke(Color.init(.dcdcdc), lineWidth: 1)
                                .frame(width: 54, height: 54)
                                .overlay {
                                    Image(.icGoogleLogo22)
                                        .frame(width: 22, height: 22)
                                }
                        }
                        .frame(width: 54, height: 54)
                        AppleLoginView { result in
                            switch result {
                            case .success(let response):
                                // TODO: 로그인 API 호출
                                path.append(.termsAgreement)
                                break
                            case .failure(let error):
                                alert.isShowing = true
                                alert.error = error
                            }
                        }.alert(isPresented: $alert.isShowing, error: alert.error) {
                            Button("확인") {
                                alert.isShowing = false
                            }
                        }
                        .frame(width: 54, height: 54)
                        KakaoLoginView { result in
                            switch result {
                            case .success(let response):
                                // TODO: 로그인 API 호출
                                break
                            case .failure(let error):
                                alert.isShowing = true
                                alert.error = error
                            }
                        }.alert(isPresented: $alert.isShowing, error: alert.error) {
                            Button("확인") {
                                alert.isShowing = false
                            }
                        }
                        .frame(width: 54, height: 54)
                    }
                    .padding([.leading, .trailing], 26)
                    .frame(maxWidth: .infinity, maxHeight: 86)
                    .background(Color(.f9F9F9))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .navigationDestination(for: LoginNavigationType.self) { dest in
                switch dest {
                case .login:
                    LoginView()
                case .regist:
                    RegistView(path: $path)
                case .termsAgreement:
                    TermsAgreementView(path: $path)
                }
            }
        }
    }
    
    func validation(isShowAlert: Bool) {
        if id.isEmpty || pw.isEmpty {
            isLoginEnabled = false
            if isShowAlert {
                invalidReason = "이메일 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요."
            } else {
                invalidReason = ""
            }
            return
        }
        
        isLoginEnabled = true
        invalidReason = ""
    }
    
    func handleAuthorization(_ authResults: ASAuthorization) {
        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let email = appleIDCredential.email
            print("User ID: \(userID)")
            print("Email: \(email ?? "No email")")
        }
    }
}

#Preview {
    LoginView()
}
