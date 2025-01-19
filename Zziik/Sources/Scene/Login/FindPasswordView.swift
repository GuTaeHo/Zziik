//
//  FindPasswordView.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI
import Then
import Combine


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
    
    @State var progress: Progress = .email
    @FocusState var focused: Progress?
    
    @State var isShowToast: Bool = false
    
    @State var count: Int = 0
    var timer = Timer.publish(every: 1.0, on: .main, in: .common)
    @State private var timerCancellable: Cancellable? = nil
    @State private var isRunning = false
    
    var body: some View {
        ZStack {
            VStack {
                CommonHeaderView(leftButtonImage: .constant(progress.headerLeftButtonImage),
                                 leftButtonAction: {
                    if let previous = progress.previous {
                        progress = previous
                    } else {
                        path.removeLast()
                    }
                })
                .frame(height: 50)
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
                                    requestSendEmail()
                                    // TODO: 인증번호 전송 API 호출, 실패 시 스낵바 표시
                                } else {
                                    // TODO: 인증번호 전송 API 호출 & 카운터 초기화
                                    certNumber.removeAll()
                                }
                            }
                        }) {
                            Text(progress.certButtonTitle)
                                .font(.custom(.regular400, size: 14))
                                .foregroundStyle(Color(._212121))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
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
            VStack {
                Spacer()
                toastView
            }
        }
        .onDisappear {
            stopTimer()
        }
        .onReceive(timer.autoconnect()) { _ in
            if count > 0 {
                count -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    @ViewBuilder
    var certView: some View {
        Spacer().frame(height: 16)
        UnderlineTextField(placeholder: "인증번호 입력",
                           text: $certNumber,
                           isForceDeleteInvisiable: true,
                           maxTextCount: Progress.certNumber.maxTextCount,
                           evaluateType: .email)
        .overlay {
            HStack {
                Spacer()
                Text(formatTime(from: count))
                    .font(.custom(.regular400, size: 12))
                    .foregroundStyle(Color(.e90202))
            }
        }
        .keyboardType(.decimalPad)
        Spacer().frame(height: 30)
        CommonButton(title: progress.passwordButtonTitle,
                     isEnabled: .constant(certNumberValidation())) {
            // TODO: 인증 번호 확인 API 호출 및 성공 시 .newPassword
            if certNumberValidation() {
                stopTimer()
                progress = .newPassword
            }
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
    
    @ViewBuilder
    var toastView: some View {
        if isShowToast {
            withAnimation {
                CommonToast(type: .positive, message: "이메일로 인증번호를 전송했어요")
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowToast = false
                            }
                        }
                    }
                    .frame(maxHeight: 50)
                    .padding(.init(horizontal: 16))
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
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
    
    private func requestSendEmail() {
        startTimer()
        isShowToast = true
        progress = .certNumber
    }
    
    func formatTime(from minutes: Int) -> String {
        let hours = minutes / 60
        let minutesRemaining = minutes % 60
        return String(format: "%d:%02d", hours, minutesRemaining)
    }
    
    private func startTimer() {
        stopTimer()
        count = 180
        isRunning = true
        timerCancellable = timer
            .autoconnect()
            .sink { _ in
                if count > 0 {
                    count -= 1
                } else {
                    // 타이머가 끝나면 뷰를 숨기거나 다른 동작을 수행
                    count = 0
                    isRunning = false
                    timerCancellable?.cancel()
                }
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        isRunning = false
    }
}

#Preview {
    FindPasswordView(path: .constant([.termsAgreement, .regist]))
}
