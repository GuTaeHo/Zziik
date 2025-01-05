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
            .cornerRadius(10)
    }
}


struct CommonButton: View {
    var title: String
    var action: (() -> ())?
    
    @Binding var isEnabled: Bool
    
    init(title: String, isEnabled: Binding<Bool>, action: (() -> ())? = nil) {
        self.title = title
        self._isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(title)
                .font(.custom(.semiBold600, size: 16))
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())  // 클릭 영역 확대
        }.onTapGesture {
            action?()
        }
        .background(isEnabled ? Color(._1B1D28) : Color(.dcdcdc))
        .foregroundStyle(isEnabled ? Color(.white) : Color(._999999))
        .cornerRadius(10)
        .buttonStyle(CommonButtonStyle())   // 커스텀 버튼 스타일
    }
}


#Preview {
    CommonButton(title: "안녕", isEnabled: .constant(true))
}
