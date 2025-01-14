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
        case newPasswordAgain
        
        var headerLeftButtonImage: ImageResource {
            switch self {
            case .email, .certNumber:
                return .icHeaderClose24
            case .newPassword, .newPasswordAgain:
                return .icHeaderBack24
            }
        }
        
        var title: String {
            switch self {
            case .email, .certNumber:
                return "비밀번호 찾기"
            case .newPassword, .newPasswordAgain:
                return "비밀번호 재설정"
            }
        }
        
        var certButtonTitle: String {
            switch self {
            case .email, .newPassword, .newPasswordAgain:
                return "인증번호 전송"
            case .certNumber:
                return "인증번호 재전송"
            }
        }
        
        var passwordButtonTitle: String {
            switch self {
            case .email, .certNumber:
                return "비밀번호 재설정"
            case .newPassword, .newPasswordAgain:
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
            case .newPasswordAgain:
                return .max
            }
        }
    }
    
    
    @Binding var path: [LoginCoordinator.Destination]
    
    @State var email: String = ""
    @State var certNumber: String = ""
    @State var progress: Progress = .email
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CommonHeaderView(leftButtonImage: .constant(progress.headerLeftButtonImage),
                                 leftButtonAction: {
                    path.removeLast()
                })
                .frame(height: 50)
                VStack(alignment: .leading) {
                    Text("비밀번호 찾기")
                        .font(.custom(.semiBold600, size: 24))
                    Spacer().frame(height: 30)
                    UnderlineTextField(placeholder: "가입하신 이메일을 입력하세요",
                                       text: $email,
                                       alertText: .constant("이메일 형식에 맞지 않습니다"),
                                       isDeleteVisiable: true,
                                       maxTextCount: Progress.email.maxTextCount,
                                       evaluateType: .email)
                    Spacer().frame(height: 20)
                    Button(action: {
                        
                    }) {
                        Text(progress.certButtonTitle)
                            .font(.custom(.regular400, size: 14))
                            .foregroundStyle(Color(._212121))
                    }
                    .border(Color(.dcdcdc), width: 1)
                    .clipShape(.rect(cornerRadius: 8))
                    .frame(width: geometry.size.width, height: 48, alignment: .center)
                }
                .padding(.init(top: 30, leading: 26, bottom: 30, trailing: 26))
                .frame(width: geometry.size.width, alignment: .leading)
            }
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    FindPasswordView(path: .constant([.termsAgreement, .regist]))
}
