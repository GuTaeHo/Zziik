//
//  SignInWithAppleView.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
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
        controller.delegate = AppleSignInCoordinator()
        controller.presentationContextProvider = AppleSignInCoordinator()
        controller.performRequests()
    }
}

class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // 현재 활성화된 UIWindow를 반환
        return UIApplication.shared.windows.first!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = credential.user
            let email = credential.email
            let fullName = credential.fullName
            print("User ID: \(userID)")
            print("Email: \(email ?? "No email")")
            print("Full Name: \(fullName?.description ?? "No name")")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization failed: \(error.localizedDescription)")
    }
}


#Preview {
    SignInWithAppleView()
}
