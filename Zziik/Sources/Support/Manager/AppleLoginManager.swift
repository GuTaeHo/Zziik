////
////  AppleLoginManager.swift
////  Zziik
////
////  Created by 구태호 on 12/26/24.
////
//
//import UIKit
//import AuthenticationServices
//
//
//class AppleLoginManager: NSObject {
//    private var loginDelegate: SocialLoginDelegate?
//    
//    init(loginDelegate: SocialLoginDelegate? = nil) {
//        self.loginDelegate = loginDelegate
//    }
//    
//    func login(context: UIViewController) {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//        
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.presentationContextProvider = context as? ASAuthorizationControllerPresentationContextProviding
//        controller.performRequests()
//    }
//}
//
//extension AppleLoginManager: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
//            loginDelegate?.lodinFailed("Apple 로그인 식별자 획득 실패")
//            return
//        }
//        
//        let jwtToken = credential.identityToken!
//        // jwtToken -> string 변환
//        let utf8EncodedToken = String(data: jwtToken, encoding: .utf8)
//        
//        if
//            let token = utf8EncodedToken,
//            let email = DecodeUtil.jwtDecode(jwtToken: token)["email"] as? String
//        {
//            loginDelegate?.loginSucceeded(.init(id: credential.user, email: email))
//        } else {
//            loginDelegate?.lodinFailed("이메일 정보를 가져올 수 없어요\n설정 > Apple ID > Apple로 로그인 >\nApple ID를 사용하는 앱 > Zziik > Apple ID 사용 중단을 체크해주세요\n\n(이메일 정보는 사용자 계정을 찾거나, 문제 발생시 연락을 위해 반드시 필요해요)")
//        }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) { }
//}
