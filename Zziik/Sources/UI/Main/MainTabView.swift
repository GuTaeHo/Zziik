//
//  TabView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


struct MainTabView: View {
    enum MainTab: Hashable {
        case home(tab: HomeView.HomeTab)
        case favorite
        case deliveryList
    }
    
    @EnvironmentObject var coordinator: Coordinator
    @State var tab: MainTab
    @State var invoiceNumber: String = ""
    
    init(tab: MainTab) {
        self.tab = tab
        
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 8),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor
            ]
        )

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
                
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = image

        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        VStack(spacing: 21) {
            HStack {
                Image(.imgZziik66)
                Spacer()
                Image(.icUserFill24)
            }
            .padding(.init(top: 19, leading: 14, bottom: 0, trailing: 21))
            .frame(minHeight: 24)
            
            CommonSearchView(action: { coordinator.push(destination: .login) },
                             placeholder: "송장번호를 입력해주세요",
                             text: $invoiceNumber)
                .padding(.init(top: 0, leading: 16, bottom: 26, trailing: 16))
        }
        .background(Color(._1B1D28))
        TabView(selection: $tab) {
            HomeView()
                .tabItem {
                    if case .home(_) = tab {
                        Image(.icHomeFill28)
                    } else {
                        Image(.icHomeLine28)
                    }
                }
                .tag(
                    Set([
                        MainTab.home(tab: .shipping),
                        MainTab.home(tab: .completed)
                    ])
                )

            FavoriteView()
                .tabItem {
                    if case .favorite = tab {
                        Image(.icFavoriteFill28)
                    } else {
                        Image(.icFavoriteLine28)
                    }
                }
                .tag(MainTab.favorite)

            DeliveryListView()
                .tabItem {
                    if case .deliveryList = tab {
                        Image(.icDeliveryListFill28)
                    } else {
                        Image(.icDeliveryListLine28)
                    }
                }
                .tag(MainTab.deliveryList)
        }
        .background(Color.gray.opacity(0.2))
    }
}


#Preview {
    MainTabView(tab: .deliveryList)
}
