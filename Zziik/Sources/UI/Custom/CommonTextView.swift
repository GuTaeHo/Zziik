//
//  CommonTextView.swift
//  Zziik
//
//  Created by 구태호 on 11/19/24.
//


import UIKit


class CommonTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        initViews()
        baseAttributes()
        initAttributes()
        binding()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViews()
        baseAttributes()
        initAttributes()
        binding()
    }
    
    // 텍스트 뷰 기본 속성
    private func baseAttributes() {
        self.backgroundColor = .clear
        self.textContainer.lineFragmentPadding = 0
        self.textContainerInset = .zero
        self.textColor = .init(resource: .ffffff)
        self.font = .font(type: .regular400, size: 16)
        self.dataDetectorTypes = .link
    }
    
    func initViews() { }
    func initAttributes() { }
    func binding() { }
}
