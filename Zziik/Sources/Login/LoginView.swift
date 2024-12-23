//
//  LoginView.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI
import Then

struct LoginView: View {
    var body: some View {
        let contentViewPadding = 28
        
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(.imgLogo92)
                    Text("기다림이 설렘으로 \n바뀌는 순간")
                        .font(.custom(.regular400, size: 30))
                }
                
                Image(.imgDeliveryBox145)
                    .frame(alignment: .trailing)
            }
            .frame(width: geometry.size.width, alignment: .topLeading)
            .padding(.init(top: 80, leading: 28, bottom: 0, trailing: 28))
        }
    }
}

#Preview {
    LoginView()
}
