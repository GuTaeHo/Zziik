//
//  Untitled.swift
//  Zziik
//
//  Created by 구태호 on 12/22/24.
//

import SwiftUI


struct UnderlinePasswordTextField: View {
    var placeholder: String
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true
    @State private var isDeleteVisiable = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                if isSecure {
                    SecureField(text: $text) { }
                        .focused($isFocused)
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
                    if isDeleteVisiable {
                        Button(action: {
                            text = ""
                            isDeleteVisiable = false
                        }) {
                            Image(.icDelete20)
                        }.frame(width: 30, height: 30, alignment: .center)
                    }
                } else {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
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
                    if isDeleteVisiable {
                        Button(action: {
                            text = ""
                            isDeleteVisiable = false
                        }) {
                            Image(.icDelete20)
                        }.frame(width: 30, height: 30, alignment: .center)
                    }
                }
            }
            Divider()
                .background(isFocused ? Color(._1_B_1_D_28) : Color.init(.DCDCDC))
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}


#Preview {
    @State var text = "안녕!"
    UnderlinePasswordTextField(placeholder: "input your text", text: $text)
}
