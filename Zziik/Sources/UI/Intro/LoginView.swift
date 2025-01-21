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
    enum FocusField {
        case id
        case pw
    }
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var loginViewModel: LoginViewModel = .init()
    @FocusState private var focusField: FocusField?
    @StateObject private var alert: CommonAlert = .init(isShowing: false)
    
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
                                UnderlineTextField(placeholder: "이메일 입력", text: $loginViewModel.id)
                                    .submitLabel(.next)
                                    .focused($focusField, equals: .id)
                                    .onAppear {
                                        withAnimation {
                                            proxy.scrollTo("idTextField", anchor: .bottom)
                                        }
                                    }
                                    .onSubmit {
                                        focusField = .pw
                                        withAnimation {
                                            proxy.scrollTo("pwTextField", anchor: .bottom)
                                        }
                                    }
                                    .onChange(of: loginViewModel.id) { _ in
                                        loginViewModel.validation(isShowAlert: false)
                                    }
                                    .id("idTextField")
                                UnderlinePasswordTextField(placeholder: "비밀번호 입력", text: $loginViewModel.pw)
                                    .submitLabel(.done)
                                    .focused($focusField, equals: .pw)
                                    .onChange(of: loginViewModel.pw) { _ in
                                        loginViewModel.validation(isShowAlert: false)
                                    }
                                    .id("pwTextField")
                                
                            }.padding(.top, 18.0)
                            
                            if loginViewModel.invalidReason.isEmpty == false {
                                HStack {
                                    Text(loginViewModel.invalidReason)
                                        .font(.custom(.regular400, size: 13))
                                        .foregroundStyle(Color.init(.e90202))
                                    Spacer()
                                }.offset(y: 12)
                            }
                            
                            VStack(spacing: 16) {
                                CommonButton(title: "로그인",
                                             isEnabled: $loginViewModel.isLoginEnable) {
                                    if loginViewModel.isLoginEnable {
                                        coordinator.push(destination: .main(tab: .home(tab: .shipping)))
                                    }
                                }.onAppear {
                                    loginViewModel.validation(isShowAlert: false)
                                }
                                
                                HStack(spacing: 0) {
                                    Button("회원가입") {
                                        coordinator.push(destination: .regist)
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
                                    Button("비밀번호 찾기") {
                                        coordinator.push(destination: .findPassword)
                                    }
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
                            coordinator.push(destination: .main(tab: .favorite))
                            break
                        case .failure(let error):
                            alert.isShowing = true
                            alert.error = error
                        }
                    }
                    .alert(isPresented: $alert.isShowing, error: alert.error) {
                        Button("확인") {
                            alert.isShowing = false
                        }
                    }
                    .frame(width: 54, height: 54)
                    KakaoLoginView { result in
                        switch result {
                        case .success(let response):
                            // TODO: 로그인 API 호출
                            coordinator.push(destination: .main(tab: .deliveryList))
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
