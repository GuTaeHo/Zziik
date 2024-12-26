//
//  CommonHeaderView.swift
//  Zziik
//
//  Created by 구태호 on 12/26/24.
//

import SwiftUI


struct CommonHeaderView: View {
    @Binding var leftButtonImage: ImageResource?
    @Binding var title: String?
    @Binding var rightButtonTitle: String?
    
    private var leftButtonAction: (() -> ())?
    private var rightButtonAction: (() -> ())?
    
    init(leftButtonImage: Binding<ImageResource?> = .constant(.icHeaderBack24), title: Binding<String?> = .constant(nil), rightButtonTitle: Binding<String?> = .constant(nil), leftButtonAction: (() -> ())? = nil, rightButtonAction: (() -> ())? = nil) {
        self._leftButtonImage = leftButtonImage
        self._title = title
        self._rightButtonTitle = rightButtonTitle
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if let leftButtonImage {
                    HStack {
                        Button(action: {
                            leftButtonAction?()
                        }) {
                            Image(leftButtonImage)
                                .foregroundStyle(Color.init(._1_B_1_D_28))
                                .frame(width: 24, height: 24)
                        }.frame(width: 36, height: 36)
                        Spacer()
                    }
                }
                
                if let title {
                    Text(title)
                        .font(.custom(.regular400, size: 18))
                        .foregroundColor(Color.init(._1_B_1_D_28))
                }
                
                if let rightButtonTitle {
                    HStack {
                        Spacer()
                        Button(action: {
                            rightButtonAction?()
                        }) {
                            Text(rightButtonTitle)
                                .font(.custom(.medium500, size: 14))
                                .foregroundColor(Color.init(._999999))
                                
                        }.padding(8)
                    }
                }
            }
            .padding([.leading, .trailing], 12)
            .frame(width: geometry.size.width, height: 50)
        }
    }
}

#Preview {
    CommonHeaderView(leftButtonImage: .constant(.icHeaderBack24), title: .constant("타이틀"), rightButtonTitle: .constant("건너뛰기"))
}
