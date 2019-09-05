//
//  CloseButton.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class CloseButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.black.setStroke()
        // self.layer.anchorPointZ
        // this defines the layer heirarchy
        
        let radius: CGFloat = self.frame.width / 2.0 - 2.0
        let rotationRadian: CGFloat = 0.25 * CGFloat.pi
        
        // self.center is specified in points in the coordinate system of its superview.
        let center = CGPoint(x: bounds.width / 2.0  / cos(rotationRadian), y: 0)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        path.move(to: CGPoint(x: center.x - 0.8 * radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x + 0.8 * radius, y: center.y))
        path.move(to: CGPoint(x: center.x, y: -0.8 * radius))
        path.addLine(to: CGPoint(x: center.x, y: 0.8 * radius))
        
        path.apply(CGAffineTransform(rotationAngle: rotationRadian))
        path.lineWidth = 2.0
        path.stroke()
    }
}
