//
//  AppCoordinator.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI

struct AppCoordinator: View {
    
    enum Destination: Hashable {
        case login
        case regist
//        case addressSearch(url: String)
        case termsAgreement
        case registComplete
        case findPassword
        
        case main(tab: MainTabView.MainTab)
    }
    
    @State private var path: [AppCoordinator.Destination] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            SplashView(path: $path)
                .navigationDestination(for: Destination.self) { dest in
                    Group {
                        switch dest {
                        case .login:
                            LoginView(path: $path)
                        case .regist:
                            RegistView(path: $path)
//                        case .addressSearch(let url):
//                            AddressSearchWebView(path: $path, url: .constant(url))
                        case .termsAgreement:
                            TermsAgreementView(path: $path)
                        case .registComplete:
                            RegistCompleteView(path: $path)
                        case .findPassword:
                            FindPasswordView(path: $path)
                        case .main(let tab):
                            MainTabView(path: $path, tab: tab)
                        }
                    }
                    .toolbar(.hidden)
                }
        }
    }
}
