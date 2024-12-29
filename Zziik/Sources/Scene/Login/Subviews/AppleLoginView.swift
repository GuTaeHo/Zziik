//
//  AppleLoginView.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginView: View {
    private var loginHandler: ((Result<SocialLoginResponse, CommonError>) -> ())
    
    private var delegate: AppleSignInCoordinator
    
    init(loginHandler: @escaping ((Result<SocialLoginResponse, CommonError>) -> ())) {
        self.loginHandler = loginHandler
        delegate = AppleSignInCoordinator()
        delegate.loginHandler = loginHandler
    }
    
    var body: some View {
        Button(action: {
            startSignInWithAppleFlow()
        }) {
            Circle()
                .fill(.black)
                .frame(width: 54, height: 54)
                .overlay {
                    Image(.icAppleLogo22)
                        .frame(width: 22, height: 22)
                }
        }.clipShape(Circle())
    }
    
    func startSignInWithAppleFlow() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = delegate
        controller.presentationContextProvider = delegate
        controller.performRequests()
    }
}

class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    var loginHandler: ((Result<SocialLoginResponse, CommonError>) -> ())?
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.currentWindow!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            loginHandler?(.failure(.message(msg: "로그인 정보를 가져올 수 없습니다")))
            return
        }

        let jwtToken = credential.identityToken!
        // jwtToken -> string 변환
        let utf8EncodedToken = String(data: jwtToken, encoding: .utf8)

        if
            let token = utf8EncodedToken,
            let email = DecodeUtil.jwtDecode(jwtToken: token)["email"] as? String
        {
            loginHandler?(.success(.init(id: credential.user, email: email)))
        } else {
            loginHandler?(.failure(.message(msg: "이메일 정보를 가져올 수 없어요\n설정 > Apple ID > Apple로 로그인 >\nApple ID를 사용하는 앱 > Zziik > Apple ID 사용 중단을 체크해주세요\n\n(이메일 정보는 사용자 계정을 찾거나, 문제 발생시 연락을 위해 반드시 필요해요)")))
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) { }
}


#Preview {
    AppleLoginView(loginHandler: { _ in })
}
