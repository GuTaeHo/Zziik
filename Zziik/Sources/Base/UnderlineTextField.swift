//
//  Untitled.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI


struct UnderlineTextField: View {
    var placeholder: String
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .padding(.top, isFocused || !text.isEmpty ? 20 : 0)
            Divider()
                .background(isFocused ? Color(._1_B_1_D_28) : Color.init(.DCDCDC))
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}


#Preview {
    @State var text = "안녕!"
    UnderlineTextField(placeholder: "input your text", text: $text)
}
