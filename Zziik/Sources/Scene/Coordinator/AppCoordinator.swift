//
//  AppCoordinator.swift
//  Zziik
//
//  Created by 구태호 on 1/14/25.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {
    enum Destination: Hashable {
        case login
        case regist
        //        case addressSearch(url: String)
        case termsAgreement
        case registComplete
        case findPassword
        
        case main(tab: MainTabView.MainTab)
    }
    
    @Published var path: [Destination] = [.registComplete]
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
    
    func changeContext(destination: Destination) {
        path.removeAll()
        path.append(destination)
    }
    
    func switchTo(destination: Destination) {
        guard !path.isEmpty else { return }
        let lastIndex = path.count - 1
        path[lastIndex] = destination
    }
}

struct AppCoordinator: View {
    @StateObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SplashView()
                .environmentObject(coordinator)
                .navigationDestination(for: Coordinator.Destination.self) { dest in
                    Group {
                        switch dest {
                        case .login:
                            LoginView()
                        case .regist:
                            RegistView()
                            //                        case .addressSearch(let url):
                            //                            AddressSearchWebView(path: $path, url: .constant(url))
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
                    .environmentObject(coordinator)
                    .toolbar(.hidden)
                }
        }
    }
}
