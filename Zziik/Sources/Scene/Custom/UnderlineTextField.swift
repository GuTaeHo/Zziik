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
    @State private var isDeleteVisiable = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .onAppear {
                        
                    }
                    .onChange(of: text) { text in
                        if text.isEmpty {
                            isDeleteVisiable = false
                        } else {
                            isDeleteVisiable = true
                        }
                    }
                    .onChange(of: isFocused) { isFocused in
                        if text.isEmpty {
                            isDeleteVisiable = false
                        } else {
                            isDeleteVisiable = true
                        }
                    }
                    .frame(height: 30)
                if isDeleteVisiable {
                    Button(action: {
                        text = ""
                        isDeleteVisiable = false
                    }) {
                        Image(.icDelete20)
                    }.frame(width: 30, height: 30, alignment: .center)
                }
            }
            ZStack {
                Rectangle()
                    .fill(Color(._1B1D28))
                    .scaleEffect(isFocused ? 1 : 0)
                    .animation(.easeOut(duration: 0.2), value: isFocused)
                Divider()
                    .background(isFocused ? Color(._1B1D28) : Color.init(.dcdcdc))
            }
            .frame(height: 1)
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}


#Preview {
    @State var text = "안녕!"
    UnderlineTextField(placeholder: "input your text", text: $text)
}
