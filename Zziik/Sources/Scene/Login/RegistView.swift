//
//  LoginView.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI
import Then

struct RegistView: View {
    enum Progress {
        case email
        case name
        case password
        case address
        case birthday
        case phoneNumber
        
        var headerLeftButtonImage: ImageResource {
            switch self {
            case .email:
                return .icHeaderClose24
            case .name, .password, .address, .birthday, .phoneNumber:
                return .icHeaderBack24
            }
        }
        
        var headerRightButtonTitle: String {
            switch self {
            case .email, .name, .password:
                return ""
            case .address, .birthday, .phoneNumber:
                return "건너뛰기"
            }
        }
        
        var title: String {
            switch self {
            case .email:
                return "이메일 입력"
            case .name:
                return "이름 입력"
            case .password:
                return "비밀번호 입력"
            case .address:
                return "주소 입력"
            case .birthday:
                return "생년월일 입력"
            case .phoneNumber:
                return "전화번호 입력"
            }
        }
        
        var essentialTitle: String {
            switch self {
            case .email, .name, .password:
                return "필수"
            case .address, .birthday, .phoneNumber:
                return "선택"
            }
        }
        
        var pageNumber: Int {
            switch self {
            case .email: 1
            case .name: 2
            case .password: 3
            case .address: 4
            case .birthday: 5
            case .phoneNumber: 6
            }
        }
        
        var maxTextCount: Int {
            switch self {
            case .email:
                return .max
            case .name:
                return .max
            case .password:
                return 15
            case .address:
                return .max
            case .birthday:
                return 8
            case .phoneNumber:
                return 12
            }
        }
        
        var next: Self? {
            switch self {
            case .email:
                return .name
            case .name:
                return .password
            case .password:
                return .address
            case .address:
                return .birthday
            case .birthday:
                return .phoneNumber
            case .phoneNumber:
                return nil
            }
        }
        
        var previous: Self? {
            switch self {
            case .email:
                return nil
            case .name:
                return .email
            case .password:
                return .name
            case .address:
                return .password
            case .birthday:
                return .address
            case .phoneNumber:
                return .birthday
            }
        }
    }
    
    private let emails = ["@naver.com", "@gmail.com", "@hanmail.com", "@nate.com", "@daum.net"]
    
    @Binding var path: [LoginNavigationType]
    
    @State var progress: Progress = .birthday
    @FocusState var focused: Progress?
    
    @State var email: String = ""
    @State var emailAlert: String = ""
    @State var name: String = ""
    @State var nameAlert: String = ""
    @State var password: String = ""
    @State var passwordAlert: String = ""
    @State var confirmPassword: String = ""
    @State var postNumber: String = ""
    @State var address: String = ""
    @State var addressDetail: String = ""
    @State var birthDate: String = ""
    @State var phoneNumber: String = ""
    
    
    @State var account: Account = .init()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                CommonHeaderView(leftButtonImage: .constant(progress.headerLeftButtonImage), rightButtonTitle: .constant(progress.headerRightButtonTitle)) {
                    if let previous = progress.previous {
                        progress = previous
                    } else {
                        path.removeLast()
                    }
                } rightButtonAction: {
                    if let next = progress.next {
                        progress = next
                    } else {
                        path.append(.termsAgreement)
                        // TODO: 약관 동의 화면 전환
                    }
                }
                    .frame(height: 50)
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            HStack {
                                Spacer()
                                Text("\(progress.pageNumber)/6")
                                    .font(.custom(.regular400, size: 12))
                                    .foregroundStyle(Color.init(._999999))
                            }
                            GeometryReader { geometry in
                                Rectangle()
                                    .fill(Color.init(.f2F2F2))
                                    .cornerRadius(1.5)
                                    .overlay(alignment: .leading) {
                                        Rectangle()
                                            .fill(Color.init(.f37B32))
                                            .frame(width: (geometry.size.width / 6) * CGFloat(progress.pageNumber))
                                            .cornerRadius(1.5)
                                    }
                                    .animation(.easeInOut, value: progress.pageNumber)
                            }.frame(height: 3)
                        }
                        .padding([.leading, .trailing], 16)
                        .padding(.top, 20)
                        .frame(width: geometry.size.width)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(progress.essentialTitle)
                                .font(.custom(.regular400, size: 14))
                                .foregroundStyle(Color.init(._212121))
                                .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                                .background(Color.init(.ebedf4))
                                .clipShape(.capsule)
                            
                            Text(progress.title)
                                .font(.custom(.semiBold600, size: 24))
                                .foregroundStyle(Color.init(._212121))
                                .padding(.top, 6)
                            
                            Spacer(minLength: 16)
                            
                            switch progress {
                            case .email:
                                UnderlineTextField(placeholder: "이메일을 입력해주세요", text: $email, alertText: $emailAlert)
                                    .focused($focused, equals: .email)
                                    .keyboardType(.emailAddress)
                                Spacer(minLength: 31)
                                CommonButton(title: "계속하기", isEnabled: .constant(RegExpUtil.evaluate(type: .email, compareWith: email))) {
                                    if RegExpUtil.evaluate(type: .email, compareWith: email) {
                                        account.email = email
                                        progress = .name
                                        focused = .name
                                    } else {
                                        emailAlert = "이메일 형식에 맞지 않아요"
                                    }
                                }
                            case .name:
                                UnderlineTextField(placeholder: "이름을 입력해주세요", text: $name, alertText: $nameAlert)
                                    .focused($focused, equals: .name)
                                Spacer(minLength: 31)
                                CommonButton(title: "계속하기", isEnabled: .constant(name.isEmpty == false)) {
                                    if name.isEmpty == false {
                                        progress = .password
                                        focused = .password
                                    } else {
                                        nameAlert = "이름을 입력해주세요"
                                    }
                                }
                            case .password:
                                UnderlineTextField(placeholder: "비밀번호를 입력해주세요", text: $password, maxTextCount: progress.maxTextCount, evaluateType: .password)
                                    .focused($focused, equals: .password)
                                    .keyboardType(.asciiCapable)
                                Spacer(minLength: 13)
                                Text("영문, 숫자 포함 8~15자로 입력해주세요")
                                    .font(.custom(.regular400, size: 13))
                                    .foregroundStyle(Color.init(._666666))
                                Spacer(minLength: 16)
                                UnderlineTextField(placeholder: "비밀번호를 다시 입력해주세요", text: $confirmPassword, alertText: $passwordAlert, maxTextCount: progress.maxTextCount)
                                    .keyboardType(.asciiCapable)
                                Spacer(minLength: 31)
                                CommonButton(title: "계속하기", isEnabled: .constant(passwordValidation())) {
                                    if passwordValidation() {
                                        progress = .address
                                        focused = .address
                                    }
                                }
                            case .address:
                                UnderlineTextField(placeholder: "우편번호", text: $postNumber)
                                Spacer(minLength: 16)
                                UnderlineTextField(placeholder: "주소", text: $address)
                                Spacer(minLength: 16)
                                UnderlineTextField(placeholder: "상세주소 입력", text: $addressDetail)
                                Spacer(minLength: 31)
                                CommonButton(title: "계속하기", isEnabled: .constant(address.isEmpty == false)) {
                                    progress = .birthday
                                    focused = .birthday
                                }
                            case .birthday:
                                UnderlineTextField(placeholder: "생년월일을 입력하세요 (YYYYMMDD)", text: $birthDate, maxTextCount: progress.maxTextCount, evaluateType: .birthday)
                                    .keyboardType(.numberPad)
                                Spacer(minLength: 31)
                                CommonButton(title: "계속하기", isEnabled: .constant(RegExpUtil.evaluate(type: .birthday, compareWith: birthDate))) {
                                    if RegExpUtil.evaluate(type: .birthday, compareWith: birthDate) {
                                        progress = .phoneNumber
                                        focused = .phoneNumber
                                    }
                                }
                            case .phoneNumber:
                                UnderlineTextField(placeholder: "전화번호를 입력하세요 (-빼고)", text: $phoneNumber, maxTextCount: progress.maxTextCount)
                                    .keyboardType(.numberPad)
                                Spacer(minLength: 31)
                                CommonButton(title: "계속하기", isEnabled: .constant(phoneNumber.isEmpty == false)) {
                                    path.append(.termsAgreement)
                                }
                            }
                        }
                        .padding(.init(top: 30, leading: 26, bottom: 0, trailing: 26))
                        .frame(width: geometry.size.width, alignment: .leading)
                    }
                }
            }
        }.toolbar(.hidden)
    }
    
    func emailValidation() -> Bool {
        return true
    }
    
    func nameValidation() -> Bool {
        return true
    }
    
    func passwordValidation() -> Bool {
        if !RegExpUtil.evaluate(type: .password, compareWith: password) {
            passwordAlert = "비밀번호 형식에 맞지 않습니다"
            return false
        }
        
        if password != confirmPassword {
            passwordAlert = "비밀번호가 서로 일치하지 않습니다"
            return false
        }
        
        return true
    }
    
    func addressValidation() -> Bool {
        return true
    }
    
    func birthDateValidation() -> Bool {
        return true
    }
    
    func phoneNumberValidation() -> Bool {
        return true
    }
}

#Preview {
    RegistView(path: .constant([.login]))
}
