//
//  KakaoLoginManager.swift
//  blossom
//
//  Created by 구태호 on 2022/07/01.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth


struct KakaoLoginView: View, SocialLoginable {
    internal var loginHandler: ((Result<SocialLoginResponse, CommonError>) -> ())
    
    init(loginHandler: @escaping ((Result<SocialLoginResponse, CommonError>) -> ())) {
        self.loginHandler = loginHandler
    }
    
    var body: some View {
        Button(action: {
            login()
        }) {
            Circle()
                .fill(Color(.ffeb00))
                .frame(width: 54, height: 54)
                .overlay {
                    Image(.icKakaoLogo22)
                        .frame(width: 22, height: 22)
                }
        }.clipShape(Circle())
    }
    
    /// 카카오 소셜 로그인을 진행합니다
    func login() {
        kakaoLogin()
    }
    
    private func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoTalkAppLogin()
        } else {
            kakaoAccountLogin()
        }
    }
    
    /// 카카오톡으로 로그인
    private func kakaoTalkAppLogin() {
        UserApi.shared.loginWithKakaoTalk() { oauthToken, error in
            if let error = error {
                loginHandler(.failure(CommonError.message(msg: error.localizedDescription)))
                return
            }
            getUserInfo()
        }
    }
    
    /// 카카오 계정으로 로그인 & 이메일 정보 동의
    private func kakaoAccountLogin() {
        UserApi.shared.loginWithKakaoAccount() { oauthToken, error in
            if let error = error {
                // 로그인 취소 시 호출
                loginHandler(.failure(CommonError.message(msg: error.localizedDescription)))
                return
            }
            getUserInfo()
        }
    }
    
    /// 유저 정보 반환
    private func getUserInfo() {
        UserApi.shared.me() { user, error in
            if let error = error {
                loginHandler(.failure(CommonError.message(msg: error.localizedDescription)))
                return
            }
            
            if let id = user?.id, let email = user?.kakaoAccount?.email {
                loginHandler(.success(.init(id: "\(id)", email: email)))
            } else {
                loginHandler(.failure(CommonError.message(msg: "유저 정보를 가져오는데 실패했어요")))
            }
        }
    }
}


#Preview {
    KakaoLoginView(loginHandler: { _ in })
}
