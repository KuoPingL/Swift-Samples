//
//  OscilloScreen.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/29.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

class OscilloScreen: UIView {
    
//    static let widthToHeightRatio: CGFloat = 198.0 / 154.0
    static let widthToHeightRatio: CGFloat = 198.0 / 100.0
    
    private var shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pathX = UIBezierPath()
        pathX.move(to: CGPoint(x: 0, y: bounds.midY))
        pathX.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        
        let pathY = UIBezierPath()
        pathY.move(to: CGPoint(x: bounds.midX, y: 0))
        pathY.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        
        UIColor.black.setStroke()
        pathX.stroke()
        pathY.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 8.0
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        backgroundColor = UIColor(201, 253, 222, a: 1)
    }
}

extension OscilloScreen {
    func addSquare() {
        let square = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 40, height: 40))
        shapeLayer.path = square.cgPath
        shapeLayer.frame = CGRect(x: bounds.midX - 20, y: bounds.midY - 20, width: 40, height: 40)
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.borderWidth = 2.0
        shapeLayer.borderColor = UIColor.blue.cgColor
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func applyTransformToSquare(_ transform: CATransform3D) {
        shapeLayer.transform = transform
    }
}

extension OscilloScreen: ThreeDimensionMatrixDelegate {
    func applyTransformation(_ transform: CATransform3D) {
        applyTransformToSquare(transform)
    }
}



