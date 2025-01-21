//
//  Untitled.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI



struct CommonButton: View {
    var title: String
    var action: (() -> ())?
    
    @Binding var isEnabled: Bool
    @State private var isChecked = false
    @State private var isPressed = false
    
    init(title: String, isEnabled: Binding<Bool>, action: (() -> ())? = nil) {
        self.title = title
        self._isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
            action?()
        }) {
            Text(title)
                .font(.custom(.semiBold600, size: 16))
                .frame(maxWidth: .infinity)
                .padding()
        }.onTapGesture {
            action?()
        }.gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                    isChecked.toggle()
                }
        )
        .background(isEnabled ? Color(._1B1D28) : Color(.dcdcdc))
        .foregroundStyle(isEnabled ? Color(.white) : Color(._999999))
        .clipShape(.rect(cornerRadius: 8))
        .scaleEffect(isPressed ? 0.95 : 1.0) // 눌림 효과
    }
}


#Preview {
    CommonButton(title: "안녕", isEnabled: .constant(true))
}
