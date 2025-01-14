//
//  CommonResizingScrollView.swift
//  Zziik
//
//  Created by 구태호 on 11/19/24.
//

import UIKit


class CommonResizingScrollView: UIScrollView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
}
