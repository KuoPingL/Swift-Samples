//
//  ShowMoreButton.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ShowMoreButton: UIButton {
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: bounds.width / 3,
                                   y: bounds.height / 4))
        arrowPath.addLine(to: CGPoint(x: bounds.width * 2 / 3,
                                      y: bounds.height / 2))
        arrowPath.addLine(to: CGPoint(x: bounds.width / 3,
                                      y: bounds.height * 3 / 4))
        UIColor.white.setStroke()
        arrowPath.lineWidth = 2.0
        arrowPath.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.LINE_SHOW_MORE_BUTTON_BACKGROUND_COLOR
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
}
