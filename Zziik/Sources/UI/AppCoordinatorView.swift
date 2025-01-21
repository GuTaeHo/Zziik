//
//  AppCoordinatorView.swift
//  Zziik
//
//  Created by 구태호 on 1/21/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject var alert = CommonAlert()
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SplashView()
                .navigationDestination(for: Coordinator.Destination.self) { dest in
                    Group {
                        switch dest {
                        case .login:
                            LoginView()
                        case .regist:
                            RegistView()
                        case .termsAgreement:
                            TermsAgreementView()
                        case .registComplete:
                            RegistCompleteView()
                        case .findPassword:
                            FindPasswordView()
                        case .main(let tab):
                            MainTabView(tab: tab)
                        }
                    }
                    .toolbar(.hidden)
                }
        }
        // MARK: 얼럿, 코디네이터 주입 (최상위 뷰에서 한번 주입)
        .environmentObject(alert)
        .environmentObject(coordinator)
    }
}
