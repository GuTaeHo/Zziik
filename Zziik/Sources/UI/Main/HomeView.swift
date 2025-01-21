//
//  HomeView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var invoiceNumber: String = ""
    
    var body: some View {
        GeometryReader { geometry in
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
        }
        .background(Color(.white))
    }
}

#Preview {
    HomeView()
}
