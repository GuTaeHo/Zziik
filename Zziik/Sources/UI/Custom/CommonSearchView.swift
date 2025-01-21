//
//  CommonSearchView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


struct CommonSearchView: View {
    var placeholder: String
    
    @Binding var text: String
    private var action: () -> Void
    private var maxTextCount: Int
    @State private var isDeleteVisiable: Bool
    @FocusState private var isFocused: Bool
    
    
    init(action: @escaping () -> Void, placeholder: String, text: Binding<String>, isDeleteVisiable: Bool = false, maxTextCount: Int = .max) {
        self.action = action
        self.placeholder = placeholder
        self._text = text
        self.isDeleteVisiable = isDeleteVisiable
        self.maxTextCount = maxTextCount
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .onAppear {
                    
                }
                .onChange(of: text) { text in
                    if text.count > maxTextCount {
                        self.text = String(text.prefix(maxTextCount))
                    }
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
                .padding(.init(all: 14))
            
            if isDeleteVisiable {
                Button(action: {
                    text = ""
                    isDeleteVisiable = false
                }) {
                    Image(.icDelete20)
                }.frame(width: 30, height: 30, alignment: .center)
            }
            
            Image(.icSearch24)
                .padding(.init(top: 12, leading: 16, bottom: 14, trailing: 16))
                .onTapGesture {
                    action()
                }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .background(Color(.white))
        .clipShape(.rect(cornerRadius: 12))
    }
}


#Preview {
    CommonSearchView(action: {}, placeholder: "input your text", text: .constant(""))
}
