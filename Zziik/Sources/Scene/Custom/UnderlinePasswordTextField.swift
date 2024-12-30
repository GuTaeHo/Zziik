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
            HStack(alignment: .center) {
                if isSecure {
                    SecureField(placeholder, text: $text) { }
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
                        .frame(height: 30)
                    
                    if text.isEmpty == false {
                        Button(action: {
                            text = ""
                            isSecure.toggle()
                        }) {
                            Image(.icPwOpen20)
                        }.frame(width: 30, height: 30, alignment: .center)
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
                        .frame(height: 30)
                    
                    if text.isEmpty == false {
                        Button(action: {
                            text = ""
                            isSecure.toggle()
                        }) {
                            Image(.icPwClose20)
                        }.frame(width: 30, height: 30, alignment: .center)
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
    UnderlinePasswordTextField(placeholder: "input your text", text: $text)
}
