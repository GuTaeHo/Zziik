//
//  TermsAgreementView.swift
//  Zziik
//
//  Created by 구태호 on 1/6/25.
//

import SwiftUI

struct TermsAgreementView: View {
    @Binding var path: [LoginNavigationType]
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                CommonHeaderView()
                    .frame(height: 50)
                ScrollView {
                    VStack {
                        Text("약관에 동의해주세요")
                            .font(.custom(.semiBold600, size: 24))
                    }
                    .padding(.init(top: 20, leading: 16, bottom: 16, trailing: 16))
                }
                .frame(width: proxy.size.width, alignment: .leading)
            }
        }
    }
}

#Preview {
    TermsAgreementView(path: .constant([.termsAgreement]))
}
