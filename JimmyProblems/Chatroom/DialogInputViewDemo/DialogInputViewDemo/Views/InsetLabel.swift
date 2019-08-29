//
//  InsetLabel.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/29.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
class InsetUILabel: UILabel {
    public var insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += insets.left + insets.right
        size.height += insets.bottom + insets.top
        return size
    }
}
