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
    /// 얼럿 텍스트, 일반 및 포커스 상태의 색상이 무시됨
    /// 텍스트 작성 시 얼럿 텍스트 제거
    @Binding var alertText: String
    private var maxTextCount: Int
    @State private var isDeleteVisiable: Bool
    private var isForceDeleteInvisiable: Bool
    @FocusState private var isFocused: Bool
    /// 정규식 체크 타입
    private var evaluateType: RegExpUtil.RegCase?
    
    
    init(placeholder: String, text: Binding<String>, alertText: Binding<String> = .constant(""), isDeleteVisiable: Bool = false, isForceDeleteInvisiable: Bool = false, maxTextCount: Int = .max, evaluateType: RegExpUtil.RegCase? = nil) {
        self.placeholder = placeholder
        self._text = text
        self._alertText = alertText
        self.isDeleteVisiable = isDeleteVisiable
        self.isForceDeleteInvisiable = isForceDeleteInvisiable
        self.maxTextCount = maxTextCount
        self.evaluateType = evaluateType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 0) {
                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .onAppear {
                        
                    }
                    .onChange(of: text) { text in
                        alertText = ""
                        if text.count > maxTextCount {
                            self.text = String(text.prefix(maxTextCount))
                        }
                        if text.isEmpty {
                            isDeleteVisiable = false
                        } else if isForceDeleteInvisiable == false {
                            isDeleteVisiable = true
                        }
                    }
                    .onChange(of: isFocused) { isFocused in
                        if text.isEmpty {
                            isDeleteVisiable = false
                        } else if isForceDeleteInvisiable == false {
                            isDeleteVisiable = true
                        }
                    }
                    .frame(height: 30)
                
                if let evaluateType, RegExpUtil.evaluate(type: evaluateType, compareWith: text) {
                    Image(.icCheck16)
                        .foregroundStyle(Color(.f37B32))
                        .frame(width: 30, height: 30, alignment: .center)
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
            ZStack {
                let isShowAlert = alertText.isEmpty == false
                Rectangle()
                    .fill(isShowAlert ? Color(.e90202) : Color(.dcdcdc))
                    .scaleEffect(isFocused ? 1 : 0)
                    .animation(.easeOut(duration: 0.2), value: isFocused)
                if isShowAlert {
                    Rectangle()
                        .fill(Color.init(.e90202))
                } else {
                    Rectangle()
                        .fill(isFocused ? Color(._1B1D28) : Color.init(.dcdcdc))
                }
            }
            .frame(height: 1)
            
            if alertText.isEmpty == false {
                Text(alertText)
                    .font(.custom(.regular400, size: 13))
                    .foregroundStyle(Color(.e90202))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}


#Preview {
    UnderlineTextField(placeholder: "input your text", text: .constant("텍스트 작성중!"), alertText: .constant("잘못된 텍스트"))
}
