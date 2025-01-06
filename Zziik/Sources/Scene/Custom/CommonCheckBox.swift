//
//  CommonCheckBox.swift
//  Zziik
//
//  Created by 구태호 on 1/6/25.
//

import SwiftUI


struct CommonCheckBox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        GeometryReader { geometry in
            if isChecked {
                Circle()
                    .fill(Color(.f37B32))
                    .overlay {
                        Image(.icCheck)
                            .resizable()
                            .foregroundStyle(Color(.white))
                            .padding(geometry.size.width / 5)
                    }.animation(.spring, value: isChecked)
            } else {
                Circle()
                    .stroke(Color(.dcdcdc), lineWidth: 1)
                    .padding(1)
                    .border(Color(.dcdcdc))
                    .animation(.spring, value: isChecked)
            }
        }
    }
}

#Preview {
    CommonCheckBox(isChecked: .constant(false))
}
