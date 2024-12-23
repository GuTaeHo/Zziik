//
//  Untitled.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI


struct CommonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.gray : .init(._1_B_1_D_28))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 눌림 효과
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct CommonButton: View {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Button(action: {
            print("Custom Button tapped")
        }) {
            Text(title)
                .font(.custom(.semiBold600, size: 16))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(CommonButtonStyle())   // 커스텀 버튼 스타일
    }
}


#Preview {
    CommonButton(title: "안녕")
}
