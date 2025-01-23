//
//  HomeView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


struct HomeView: View {
    enum HomeTab: Hashable {
        case shipping
        case completed
    }
    
    @EnvironmentObject var coordinator: Coordinator
    @State var tab: HomeTab = .completed
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 32) {
                Button(action: {
                    tab = .shipping
                }) {
                    VStack(spacing: 12) {
                        Text("배송중")
                            .font(tab == .shipping ? .custom(.semiBold600, size: 16) : .custom(.regular400, size: 16))
                            .foregroundStyle(tab == .shipping ? Color(._1B1D28) : Color(._999999))
                            .background(GeometryReader { geometry in
                                Divider()
                                    .frame(width: geometry.size.width, height: 2)
                                    .background(tab == .shipping ? Color(._1B1D28) : Color(.clear))
                                    .offset(x: 0, y: geometry.size.height + 12)
                            })
                    }
                }
                .padding(.init(top: 20, leading: 16, bottom: 12, trailing: 0))
                Button(action: {
                    tab = .completed
                }) {
                    VStack(spacing: 12) {
                        Text("배송완료")
                            .font(tab == .completed ? .custom(.semiBold600, size: 16) : .custom(.regular400, size: 16))
                            .foregroundStyle(tab == .completed ? Color(._1B1D28) : Color(._999999))
                            .background(GeometryReader { geometry in
                                Divider()
                                    .frame(width: geometry.size.width, height: 2)
                                    .background(tab == .completed ? Color(._1B1D28) : Color(.clear))
                                    .offset(x: 0, y: geometry.size.height + 12)
                            })
                    }
                }
            }
            .frame(height: 54, alignment: .leading)
            TabView(selection: $tab)  {
                HomeShippingView()
                    .tag(HomeTab.shipping)
                HomeShippingCompleteView()
                    .tag(HomeTab.completed)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .background(Color(.white))
    }
}

#Preview {
    HomeView()
}
