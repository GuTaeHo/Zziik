//
//  DeliveryListView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


struct DeliveryListView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("DeliveryListView")
            Button(action: {
                coordinator.switchTo(context: .intro)
            }) {
                Text("로그아웃")
            }
        }
    }
}

#Preview {
    DeliveryListView()
}
