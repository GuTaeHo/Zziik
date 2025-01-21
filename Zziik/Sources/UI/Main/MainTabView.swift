//
//  TabView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


struct MainTabView: View {
    enum MainTab: Hashable {
        enum HomeTab {
            case shipping
            case completed
        }
        case home(tab: HomeTab)
        case favorite
        case deliveryList
    }
    
    @EnvironmentObject var coordinator: Coordinator
    @State var tab: MainTab
    
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
        TabView(selection: $tab) {
            HomeView()
                .tabItem {
                    if case .home(_) = tab {
                        Image(.icHomeFill28)
                    } else {
                        Image(.icHomeLine28)
                    }
                }
                .tag(MainTab.home(tab: .shipping))

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
