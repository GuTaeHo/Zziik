//
//  TermsAgreementView.swift
//  Zziik
//
//  Created by 구태호 on 1/6/25.
//

import SwiftUI

struct TermsAgreementView: View {
    @Binding var path: [LoginNavigationType]
    
    class CheckState: ObservableObject {
        @Published var isAllCheck: Bool = false
        @Published var isServiceAgree: Bool = false
        @Published var isUserInfoAgree: Bool = false
        @Published var isThirdPartyAgree: Bool = false
        @Published var isMarketingAgree: Bool = false
        @Published var is14Over: Bool = false
    }
    
    @StateObject private var checkState = CheckState()
    
    var termsInfoAttributedText: AttributedString {
        var string = AttributedString("입력하신 정보는 암호화되어 안전하게 저장되며,\nzziik 서비스 이용을 위해서만 사용됩니다")
        string.font = .custom(.regular400, size: 14)
        string.foregroundColor = Color(._666666)
        if let this = string.range(of: "zziik 서비스 이용") {
            string[this].font = .custom(.medium500, size: 14)
            string[this].foregroundColor = Color(._212121)
        }
        return string
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                CommonHeaderView()
                    .frame(height: 50)
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("약관에 동의해주세요")
                            .font(.custom(.semiBold600, size: 24))
                        Spacer(minLength: 12)
                        Text(termsInfoAttributedText)
                    }
                    .padding(.init(top: 20, leading: 26, bottom: 0, trailing: 16))
                    .frame(width: proxy.size.width, alignment: .leading)
                    VStack {
                        HStack(spacing: 8) {
                            CommonCheckBox(isChecked: .constant(isEnabled()))
                                .frame(width: 20, height: 20)
                            Text("약관 전체동의")
                                .font(.custom(.medium500, size: 16))
                                .foregroundStyle(Color(._212121))
                            Spacer()
                        }
                        .clipShape(.rect(cornerRadius: 8))
                        .foregroundStyle(Color(.f9F9F9))
                        .padding(.init(all: 16))
                        .onTapGesture {
                            checkState.isAllCheck.toggle()
                            if checkState.isAllCheck == true {
                                checkState.isServiceAgree = true
                                checkState.isUserInfoAgree = true
                                checkState.isThirdPartyAgree = true
                                checkState.isMarketingAgree = true
                            } else {
                                checkState.isServiceAgree = false
                                checkState.isUserInfoAgree = false
                                checkState.isThirdPartyAgree = false
                                checkState.isMarketingAgree = false
                            }
                        }
                        .onReceive(checkState.objectWillChange) {
//                            if checkState.isServiceAgree, checkState.isUserInfoAgree, checkState.isThirdPartyAgree, checkState.isMarketingAgree {
//                                checkState.isAllCheck = true
//                            } else {
//                                checkState.isAllCheck = false
//                            }
                        }
                    }
                    .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16))
                    VStack(alignment: .leading, spacing: 18) {
                        HStack(alignment: .center, spacing: 4) {
                            if checkState.isServiceAgree {
                                Image(.icCheck).foregroundStyle(Color(._212121))
                                    .frame(width: 20, height: 20)
                            } else {
                                Image(.icCheck).foregroundStyle(Color(.dcdcdc))
                                    .frame(width: 20, height: 20)
                            }
                            Text("[필수] 서비스 이용약관")
                                .font(.custom(.regular400, size: 16))
                                .foregroundStyle(Color(._212121))
                            Spacer()
                            Button(action: {}) {
                                Text("보기")
                                    .font(.custom(.regular400, size: 12))
                                    .foregroundStyle(Color(._999999))
                            }.frame(width: 37, height: 25)
                        }.onTapGesture {
                            checkState.isServiceAgree.toggle()
                        }
                        HStack(alignment: .center, spacing: 4) {
                            if checkState.isUserInfoAgree {
                                Image(.icCheck).foregroundStyle(Color(._212121))
                                    .frame(width: 20, height: 20)
                            } else {
                                Image(.icCheck).foregroundStyle(Color(.dcdcdc))
                                    .frame(width: 20, height: 20)
                            }
                            Text("[필수] 개인정보 수집 및 이용 동의")
                                .font(.custom(.regular400, size: 16))
                                .foregroundStyle(Color(._212121))
                            Spacer()
                            Button(action: {}) {
                                Text("보기")
                                    .font(.custom(.regular400, size: 12))
                                    .foregroundStyle(Color(._999999))
                            }.frame(width: 37, height: 25)
                        }.onTapGesture {
                            checkState.isUserInfoAgree.toggle()
                        }
                        HStack(alignment: .center, spacing: 4) {
                            if checkState.isThirdPartyAgree {
                                Image(.icCheck).foregroundStyle(Color(._212121))
                                    .frame(width: 20, height: 20)
                            } else {
                                Image(.icCheck).foregroundStyle(Color(.dcdcdc))
                                    .frame(width: 20, height: 20)
                            }
                            Text("[필수] 개인정보 취급 위탁 동의")
                                .font(.custom(.regular400, size: 16))
                                .foregroundStyle(Color(._212121))
                            Spacer()
                            Button(action: {}) {
                                Text("보기")
                                    .font(.custom(.regular400, size: 12))
                                    .foregroundStyle(Color(._999999))
                            }.frame(width: 37, height: 25)
                        }.onTapGesture {
                            checkState.isThirdPartyAgree.toggle()
                        }
                        HStack(alignment: .center, spacing: 4) {
                            if checkState.isMarketingAgree {
                                Image(.icCheck).foregroundStyle(Color(._212121))
                                    .frame(width: 20, height: 20)
                            } else {
                                Image(.icCheck).foregroundStyle(Color(.dcdcdc))
                                    .frame(width: 20, height: 20)
                            }
                            Text("[선택] 마케팅 정보 수신 동의")
                                .font(.custom(.regular400, size: 16))
                                .foregroundStyle(Color(._212121))
                            Spacer()
                            Button(action: {}) {
                                Text("보기")
                                    .font(.custom(.regular400, size: 12))
                                    .foregroundStyle(Color(._999999))
                            }.frame(width: 37, height: 25)
                        }.onTapGesture {
                            checkState.isMarketingAgree.toggle()
                        }
                    }
                    .padding(.init(top: 20, leading: 22, bottom: 20, trailing: 18))
                }
                .frame(width: proxy.size.width)
            }
            
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                HStack(alignment: .center, spacing: 4) {
                    CommonCheckBox(isChecked: $checkState.is14Over)
                        .frame(width: 20, height: 20)
                    Text("만 14세 이상의 사용자입니다.")
                        .font(.custom(.regular400, size: 16))
                        .foregroundStyle(Color(._212121))
                    Spacer()
                }.onTapGesture {
                    checkState.isMarketingAgree.toggle()
                }
                .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
                CommonButton(title: "가입완료", isEnabled: .constant(isEnabled())) {
                    
                }
                .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
    }
    
    func isEnabled() -> Bool {
        if checkState.isServiceAgree,
        checkState.isUserInfoAgree,
        checkState.isThirdPartyAgree {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    TermsAgreementView(path: .constant([.termsAgreement]))
}
