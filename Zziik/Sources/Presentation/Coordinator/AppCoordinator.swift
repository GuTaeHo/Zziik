//
//  AppCoordinator.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI

final class Coordinator: ObservableObject {
    enum Destination: Hashable {
        case login
        case regist
        case termsAgreement
        case registComplete
        case findPassword
        
        case main(tab: MainTabView.MainTab)
    }
    
    enum Context: Hashable {
        case intro
        case main(tab: MainTabView.MainTab)
    }
    
    @Published var path: [Destination] = []
    public init() { }
    
    func push(destination: Destination) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func pop(depth: Int) {
        guard path.count - 1 >= depth else { return }
        path.removeLast(depth)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    /// 이전 화면과 `destination` 으로 교체
    func switchTo(destination: Destination) {
        guard !path.isEmpty else { return }
        let lastIndex = path.count - 1
        path[lastIndex] = destination
    }
    
    /// 화면 스택을 `context` 로 교체
    func switchTo(context: Context) {
        path.removeAll()
        
        switch context {
        case .intro:
            path.append(.login)
        case .main(let tab):
            path.append(.main(tab: tab))
        }
    }
}

struct AppCoordinator: View {
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
        // MARK: 코디네이터 주입 (최상위 뷰에서 한번 주입)
        .environmentObject(coordinator)
    }
}
