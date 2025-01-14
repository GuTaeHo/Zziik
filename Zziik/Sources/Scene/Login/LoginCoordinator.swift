//
//  LoginCoordinator.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI

struct LoginCoordinator: View {
    enum Destination {
        case login
        case regist
        case termsAgreement
        case registComplete
    }
    
    @State private var path: [LoginCoordinator.Destination] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path: $path)
                .navigationDestination(for: Destination.self) { dest in
                    switch dest {
                    case .login:
                        LoginView(path: $path)
                    case .regist:
                        RegistView(path: $path)
                    case .termsAgreement:
                        TermsAgreementView(path: $path)
                    case .registComplete:
                        RegistCompleteView(path: $path)
                    }
                }
        }
    }
}
