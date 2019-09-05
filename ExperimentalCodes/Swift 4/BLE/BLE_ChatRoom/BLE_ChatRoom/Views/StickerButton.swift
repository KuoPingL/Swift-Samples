//
//  StickerButton.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class StickerButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        var facePath = UIBezierPath(arcCenter: center, radius: bounds.width/2.0 - 5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        faceStroke(facePath)
        
        facePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/3.0, y: bounds.height/5.0 * 2.0), radius: 0.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        faceStroke(facePath)
        
        facePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width*2.0/3.0, y: bounds.height/5.0 * 2.0), radius: 0.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        faceStroke(facePath)
        
        facePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2.0, y: bounds.height/2.0), radius: (bounds.width/2.0 - 5) / 2.0 - 5.0, startAngle: CGFloat.pi / 5.0, endAngle: CGFloat.pi / 5.0 * 4.0, clockwise: true)
        faceStroke(facePath)
    }
    
    private func faceStroke(_ path: UIBezierPath) {
        if isSelected {
            UIColor.LINE_STICKER_BUTTON_SELECTED_COLOR.setStroke()
        } else {
            UIColor.LINE_BUTTON_STROKE_COLOR.setStroke()
        }
        path.lineWidth = 1.5
        path.stroke()
    }
    
//    lazy var myView: UIView = {
//        let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 500))
//        v.sizeToFit()
//        v.backgroundColor = .blue
//        return v
//    }()
//    var toolBarView = UIView()
//
//    override var inputView: UIView {
//        return self.myView
//    }
    
    lazy var vc: UIInputViewController = {
        let vc = StickerInputViewController()
        vc.view.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4))
        vc.view.backgroundColor = .blue
        vc.view.sizeToFit()
        return vc
    }()
    
    override var inputViewController: UIInputViewController? {
        vc.becomeFirstResponder()
        return vc
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

}

extension FloatingPoint {
    public func root() -> Self {
        return self * self
    }
}
