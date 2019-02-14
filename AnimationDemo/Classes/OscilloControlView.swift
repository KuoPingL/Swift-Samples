//
//  OscilloControlView.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/30.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

class OscilloControlView: UIView {
    private let switcher: Switcher = {
        let v = Switcher()
        v.setTitle("Show", for: .normal)
        v.tintColor = UIColor.white
        v.backgroundColor = UIColor.blue
        v.layer.borderWidth = 3.0
        v.layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        
    }
}

protocol SwitcherDelegate: class {
    func didPressedInside()
}

class Switcher: UIButton {
    
    private var defaultColor: UIColor?
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 10, height: size.height + 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        defaultColor = backgroundColor
        backgroundColor = defaultColor?.withAlphaComponent(0.5)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        backgroundColor = defaultColor
    }
}

class SwitcherGradiented: UIButton {
    
    private var clickerGradient = CAGradientLayer()
    var isOn: Bool = false {
        didSet {
           setGradient()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.blue.setStroke()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 6, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.width - 6, y: bounds.midY))
        path.lineWidth = 4.0
        path.stroke()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
    }
    
    private func setGradient() {
//        clickerGradient.removeFromSuperlayer()
//        UIColor.black.setStroke()
        let outLine = UIBezierPath(rect: bounds.insetBy(dx: 5, dy: 5))
        outLine.lineWidth = 2.0

        let shape = CAShapeLayer()
        shape.frame = bounds.insetBy(dx: 5, dy: 5)
        shape.path = outLine.cgPath
        shape.fillColor = UIColor.purple.cgColor
        
        clickerGradient.frame = shape.frame
        clickerGradient.colors = [UIColor(white: 0.5, alpha: 1).cgColor, UIColor(white: 0.95, alpha: 0.6).cgColor]
        clickerGradient.startPoint = CGPoint(x: 0.5, y: 1)
        clickerGradient.endPoint = CGPoint(x: 0.5, y: 0)

        if isOn {
            clickerGradient.startPoint = CGPoint(x: 0.5, y: 0)
            clickerGradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
        
        
        clickerGradient.borderColor = UIColor.black.cgColor
        clickerGradient.borderWidth = layer.borderWidth
        clickerGradient.cornerRadius = layer.cornerRadius
        clickerGradient.mask = shape
        layer.insertSublayer(clickerGradient, at: 0)
    }
}
