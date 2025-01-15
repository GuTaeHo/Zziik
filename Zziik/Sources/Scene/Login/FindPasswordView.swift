//
//  FindPasswordView.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI
import Then


struct FindPasswordView: View {
    enum Progress {
        case email
        case certNumber
        case newPassword
        
        var headerLeftButtonImage: ImageResource {
            switch self {
            case .email, .certNumber:
                return .icHeaderClose24
            case .newPassword:
                return .icHeaderBack24
            }
        }
        
        var title: String {
            switch self {
            case .email, .certNumber:
                return "비밀번호 찾기"
            case .newPassword:
                return "비밀번호 재설정"
            }
        }
        
        var certButtonTitle: String {
            switch self {
            case .email, .newPassword:
                return "인증번호 전송"
            case .certNumber:
                return "인증번호 재전송"
            }
        }
        
        var passwordButtonTitle: String {
            switch self {
            case .email, .certNumber:
                return "비밀번호 재설정"
            case .newPassword:
                return "비밀번호 변경"
            }
        }
        
        var maxTextCount: Int {
            switch self {
            case .email:
                return .max
            case .certNumber:
                return 6
            case .newPassword:
                return 15
            }
        }
        
        var previous: Self? {
            switch self {
            case .email, .certNumber:
                return nil
            case .newPassword:
                return .certNumber
            }
        }
    }
    
    
    @Binding var path: [LoginCoordinator.Destination]
    
    @State var email: String = ""
    @State var emailAlert: String = ""
    @State var certNumber: String = ""
    @State var newPassword: String = ""
    @State var newPasswordAlert: String = ""
    @State var confirmPassword: String = ""
    
    @State var progress: Progress = .newPassword
    @FocusState var focused: Progress?
    
    var body: some View {
            VStack {
                CommonHeaderView(leftButtonImage: .constant(progress.headerLeftButtonImage),
                                 leftButtonAction: {
                    if let previous = progress.previous {
                        progress = previous
                    } else {
                        path.removeLast()
                    }
                })
                .frame(width: .infinity, height: 50)
                VStack(alignment: .leading) {
                    Text(progress.title)
                        .font(.custom(.semiBold600, size: 24))
                    Spacer().frame(height: 30)
                    
                    if progress == .email || progress == .certNumber {
                        UnderlineTextField(placeholder: "가입하신 이메일을 입력하세요",
                                           text: $email,
                                           alertText: $emailAlert,
                                           maxTextCount: Progress.email.maxTextCount,
                                           evaluateType: .email)
                        .onChange(of: email) { _ in
                            emailAlert = ""
                        }
                        Spacer().frame(height: 20)
                        Button(action: {
                            if emailValidation() {
                                if progress == .email {
                                    // TODO: 인증번호 전송 API 호출
                                } else {
                                    // TODO: 인증번호 전송 API 호출 & 카운터 초기화
                                    certNumber.removeAll()
                                }
                            }
                        }) {
                            Text(progress.certButtonTitle)
                                .padding()
                                .font(.custom(.regular400, size: 14))
                                .foregroundStyle(Color(._212121))
                                .frame(width: .infinity, height: 50)
                        }
                        .frame(maxWidth: .infinity)
                        .clipShape(.rect(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.dcdcdc), lineWidth: 1)
                        }
                    }
                    
                    if progress == .certNumber {
                        certView
                            .animation(.easeInOut, value: progress)
                    }
                    
                    if progress == .newPassword {
                        newPasswordView
                            .animation(.easeInOut, value: progress)
                    }
                    Spacer()
                }
                .padding(.init(top: 30, leading: 26, bottom: 30, trailing: 26))
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    @ViewBuilder
    var certView: some View {
        Spacer().frame(height: 16)
        UnderlineTextField(placeholder: "인증번호 입력",
                           text: $certNumber,
                           maxTextCount: Progress.certNumber.maxTextCount,
                           evaluateType: .email)
        .keyboardType(.decimalPad)
        Spacer().frame(height: 30)
        CommonButton(title: progress.passwordButtonTitle,
                     isEnabled: .constant(certNumberValidation())) {
            // TODO: 인증 번호 확인 API 호출 및 성공 시 .newPassword
            progress = .newPassword
        }
    }
    
    @ViewBuilder
    var newPasswordView: some View {
        UnderlineTextField(placeholder: "새로운 비밀번호를 입력해주세요",
                           text: $newPassword,
                           maxTextCount: progress.maxTextCount,
                           evaluateType: .password)
            .focused($focused, equals: .newPassword)
            .keyboardType(.asciiCapable)
        Spacer().frame(height: 13)
        Text("영문, 숫자 포함 8~15자로 입력해주세요")
            .font(.custom(.regular400, size: 13))
            .foregroundStyle(Color.init(._666666))
        Spacer().frame(height: 16)
        UnderlineTextField(placeholder: "비밀번호를 다시 입력해주세요",
                           text: $confirmPassword,
                           alertText: $newPasswordAlert,
                           maxTextCount: progress.maxTextCount)
            .keyboardType(.asciiCapable)
        Spacer().frame(height: 30)
        CommonButton(title: progress.passwordButtonTitle, isEnabled: .constant(passwordValidation())) {
            if passwordValidation() {
                // TODO: 비밀번호 재설정 API 호출, 성공 시 비밀번호 변경 완료 화면 이동
            }
        }
    }
    
    func emailValidation() -> Bool {
        if RegExpUtil.evaluate(type: .email, compareWith: email) {
            emailAlert = ""
            return true
        } else {
            emailAlert = "이메일 형식에 맞지 않아요"
            return false
        }
    }
    
    func certNumberValidation() -> Bool {
        certNumber.count == progress.maxTextCount
    }
    
    func passwordValidation() -> Bool {
        if !RegExpUtil.evaluate(type: .password, compareWith: newPassword) {
            newPasswordAlert = "비밀번호 형식에 맞지 않습니다"
            return false
        }
        
        if newPassword != confirmPassword {
            newPasswordAlert = "비밀번호가 서로 일치하지 않습니다"
            return false
        }
        
        return true
    }
}

#Preview {
    FindPasswordView(path: .constant([.termsAgreement, .regist]))
}
