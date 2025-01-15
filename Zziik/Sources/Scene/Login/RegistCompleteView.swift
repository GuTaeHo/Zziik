//
//  RegistCompleteView.swift
//  Zziik
//
//  Created by 구태호 on 1/13/25.
//

import SwiftUI

struct RegistCompleteView: View {
    @Binding var path: [LoginCoordinator.Destination]
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer().frame(height: 160)
                Image(.imgAirplane230)
                Spacer().frame(height: 36)
                VStack(spacing: 24) {
                    Text("회원가입 완료!\nzziik의 회원이 되신걸 환영해요.")
                        .multilineTextAlignment(.center)
                        .font(.custom(.semiBold600, size: 24))
                        .foregroundStyle(Color(._212121))
                    Text("이제 해외배송상태를 한눈에 확인하고,\n택배의 위치를 실시간으로 추적해보세요!")
                        .multilineTextAlignment(.center)
                        .font(.custom(.regular400, size: 16))
                        .foregroundStyle(Color(._666666))
                }
                Spacer()
                Button(action: {
                    
                }) {
                    HStack(spacing: 4) {
                        Image(.imgZziik52)
                        Text("시작하기")
                            .font(.custom(.semiBold600, size: 16))
                            .foregroundStyle(Color(.ffffff))
                    }
                }
                .frame(width: proxy.size.width - 32, height: 56)
                .background(Color(._1B1D28))
                .clipShape(.rect(cornerRadius: 8))
            }
            .frame(width: proxy.size.width)
        }
    }
}

#Preview {
    RegistCompleteView(path: .constant([.registComplete]))
}
