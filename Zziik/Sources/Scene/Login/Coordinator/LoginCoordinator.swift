//
//  LoginCoordinator.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI

struct LoginCoordinator: View {
    enum Destination: Hashable {
        case login
        case regist
        case addressSearch(url: String)
        case termsAgreement
        case registComplete
        case findPassword
    }
    
    @State private var path: [LoginCoordinator.Destination] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path: $path)
                .navigationDestination(for: Destination.self) { dest in
                    Group {
                        switch dest {
                        case .login:
                            LoginView(path: $path)
                        case .regist:
                            RegistView(path: $path)
                        case .addressSearch(let url):
                            AddressSearchWebView(path: $path, url: .constant(url))
                        case .termsAgreement:
                            TermsAgreementView(path: $path)
                        case .registComplete:
                            RegistCompleteView(path: $path)
                        case .findPassword:
                            FindPasswordView(path: $path)
                        }
                    }
                    .toolbar(.hidden)
                }
        }
    }
}
