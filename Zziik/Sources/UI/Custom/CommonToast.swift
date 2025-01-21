//
//  CommonToast.swift
//  Zziik
//
//  Created by 구태호 on 1/5/25.
//

import SwiftUI

struct CommonToast: View {
    enum Case {
        case positive
        case negative
    }
    
    struct ButtonConfiguration {
        var title: String
        var action: (() -> ())?
    }
    
    let type: Case
    let message: String
    let buttonConfiguration: ButtonConfiguration?
    
    init(type: Case, message: String, buttonConfiguration: ButtonConfiguration? = nil) {
        self.type = type
        self.message = message
        self.buttonConfiguration = buttonConfiguration
    }
    
    var body: some View {
        Rectangle()
            .fill(Color(.black).opacity(0.6))
            .clipShape(.rect(cornerRadius: 8))
            .overlay {
                HStack(alignment: .top, spacing: 12) {
                    if type == .positive {
                        Image(.imgToastComplete18)
                    } else {
                        Image(.imgToastArror18)
                    }
                    Text(message)
                        .font(.custom(.regular400, size: 16))
                        .foregroundStyle(Color(.white))
                    Spacer()
                    if let buttonConfiguration {
                        Button(action: {
                            buttonConfiguration.action?()
                        }) {
                            Text(buttonConfiguration.title)
                                .font(.custom(.regular400, size: 13))
                                .foregroundStyle(Color(.white))
                                .padding(.init(horizontal: 9, vertical: 6))
                        }
                    }
                }.padding(16)
            }
    }
}

#Preview {
    CommonToast(type: .positive, message: "안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕!", buttonConfiguration: .init(title: "로봇"))
        .frame(width: .infinity, height: 200, alignment: .center)
}
