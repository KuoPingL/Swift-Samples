//
//  ThreeDimensionMatrix.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/30.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

protocol ThreeDimensionMatrixDelegate: class {
    func applyTransformation(_ transform: CATransform3D)
}

class ThreeDimensionMatrixView: UIView {
    
    var delegate: ThreeDimensionMatrixDelegate?
    
    /// Identity
    private var newTransform = CATransform3DIdentity
    
    private let m11: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m11.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 100, 100, a: 1)
        return b
    }()
    
    private let m12: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m12.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(120, 100, 100, a: 1)
        return b
    }()
    
    private let m13: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m13.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(140, 100, 100, a: 1)
        return b
    }()
    
    private let m14: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m14.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(160, 100, 100, a: 1)
        return b
    }()
    
    private let m21: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m21.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 120, 100, a: 1)
        return b
    }()
    
    private let m22: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m22.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 140, 100, a: 1)
        return b
    }()
    
    private let m23: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m23.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 160, 100, a: 1)
        return b
    }()
    
    private let m24: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m24.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 180, 100, a: 1)
        return b
    }()
    
    private let m31: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m31.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 100, 120, a: 1)
        return b
    }()
    
    private let m32: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m32.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 100, 140, a: 1)
        return b
    }()
    
    private let m33: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m33.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 100, 160, a: 1)
        return b
    }()
    
    private let m34: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m34.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(100, 100, 180, a: 1)
        return b
    }()
    
    private let m41: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m41.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(200, 200, 200, a: 1)
        return b
    }()
    
    private let m42: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m42.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(220, 200, 200, a: 1)
        return b
    }()
    
    private let m43: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m43.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(240, 200, 200, a: 1)
        return b
    }()
    
    private let m44: UIButton = {
        let b = UIButton()
        b.setAttributedTitle(
            ThreeDimensionMatrixUnit.m44.attributedString(),
            for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor(255, 200, 200, a: 1)
        return b
    }()
    
    private var switchButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Show Values", for: .normal)
        return b
    }()
    
    private var slider: ValueSlider = {
        let v = ValueSlider()
        v.minimumValue = -1
        v.maximumValue = 1
        v.setThumbImage(UIImage(named: "marker"), for: .normal)
        return v
    }()
    
    private var isShowingValues = false
    
    private var selectedMButton: UIButton? {
        didSet {
            if selectedMButton == nil {
                isShowingValues = false
            } else {
                isShowingValues = true
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor.black.setStroke()
        
        let leftBracketPath = UIBezierPath()
        leftBracketPath.move(to: CGPoint(x: 10, y: 0))
        leftBracketPath.addLine(to: CGPoint(x: 0, y: 0))
        leftBracketPath.addLine(to: CGPoint(x: 0, y: bounds.height))
        leftBracketPath.addLine(to: CGPoint(x: 10, y: bounds.height))
        leftBracketPath.lineWidth = 5.0
        
        let rightBracketPath = UIBezierPath()
        rightBracketPath.move(to: CGPoint(x: bounds.width - 10, y: 0))
        rightBracketPath.addLine(to: CGPoint(x: bounds.width, y: 0))
        rightBracketPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        rightBracketPath.addLine(to: CGPoint(x: bounds.width - 10, y: bounds.height))
        rightBracketPath.lineWidth = 5.0
        
        leftBracketPath.stroke()
        rightBracketPath.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        backgroundColor = UIColor(white: 0.95, alpha: 0.8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addMatrix()
        addSwitchButton()
        addSlider()
    }
    
    //MARK: MATRIX VIEW
    private func addMatrix() {
        // Add buttons to View
        addSubview(m11)
        addSubview(m12)
        addSubview(m13)
        addSubview(m14)
        
        addSubview(m21)
        addSubview(m22)
        addSubview(m23)
        addSubview(m24)
        
        addSubview(m31)
        addSubview(m32)
        addSubview(m33)
        addSubview(m34)
        
        addSubview(m41)
        addSubview(m42)
        addSubview(m43)
        addSubview(m44)
        
        // Align all the Buttons
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("H:|[v0][v1][v2][v3]|", views: m11, m12, m13, m14))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("H:|[v0][v1][v2][v3]|", views: m21, m22, m23, m24))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("H:|[v0][v1][v2][v3]|", views: m31, m32, m33, m34))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("H:|[v0][v1][v2][v3]|", views: m41, m42, m43, m44))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("V:|[v0][v1][v2][v3]", views: m11, m21, m31, m41))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("V:|[v0][v1][v2][v3]", views: m12, m22, m32, m42))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("V:|[v0][v1][v2][v3]", views: m13, m23, m33, m43))
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("V:|[v0][v1][v2][v3]", views: m14, m24, m34, m44))
        
        addConstraints([
            
            m11.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            m11.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25, constant: -10),
            m12.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m13.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m14.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m21.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m22.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m23.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m24.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m31.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m32.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m33.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m34.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m41.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m42.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m43.widthAnchor.constraint(equalTo: m11.widthAnchor),
            m44.widthAnchor.constraint(equalTo: m11.widthAnchor),
            
            m12.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m13.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m14.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m21.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m22.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m23.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m24.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m31.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m32.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m33.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m34.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m41.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m42.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m43.heightAnchor.constraint(equalTo: m11.heightAnchor),
            m44.heightAnchor.constraint(equalTo: m11.heightAnchor)
            ])
        
        // Add actions to all buttons
        m11.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m12.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m13.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m14.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m21.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m22.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m23.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m24.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m31.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m32.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m33.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m34.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m41.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m42.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m43.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
        m44.addTarget(self,
                      action: #selector(buttonClicked(_:)),
                      for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ button: UIButton) {
        var unit: ThreeDimensionMatrixUnit = .m11
        var value = newTransform.m11
        
        if let previousButton = selectedMButton {
            
            previousButton.backgroundColor = nil
            slider.isHidden = true
            switchButton.isHidden = false
            showTransformParameters()
            
            if previousButton == button {
                // If it was selected previously
                // Simply hide slider and return
                selectedMButton = nil
                return
            }
        }
        // When selectedMButton == nil || selectedMButton != button
        selectedMButton = button
        button.backgroundColor = .lightGray
        slider.isHidden = false
        switchButton.isHidden = true
        showTransformValues()
        
        switch button {
        case m12:
            unit = .m12
            value = newTransform.m12
        case m13:
            unit = .m13
            value = newTransform.m13
        case m14:
            unit = .m14
            value = newTransform.m14
        case m21:
            unit = .m21
            value = newTransform.m21
        case m22:
            unit = .m22
            value = newTransform.m22
        case m23:
            unit = .m23
            value = newTransform.m23
        case m24:
            unit = .m24
            value = newTransform.m24
        case m31:
            unit = .m31
            value = newTransform.m31
        case m32:
            unit = .m32
            value = newTransform.m32
        case m33:
            unit = .m33
            value = newTransform.m33
        case m34:
            unit = .m34
            value = newTransform.m34
        case m41:
            unit = .m41
            value = newTransform.m41
        case m42:
            unit = .m42
            value = newTransform.m42
        case m43:
            unit = .m43
            value = newTransform.m43
        case m44:
            unit = .m44
            value = newTransform.m44
        default:
            break;
        }
        
        ADDebug.printer("UNIT : \(unit.rawValue)\nVALUE : \(value)")
        
        slider.setValue(Float(value), animated: false)
    }
    
    func showTransformValues() {
        switchButton.setTitle("Show Parameters", for: .normal)
        m11.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m11)),
            for: .normal)
        m12.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m12)),
            for: .normal)
        m13.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m13)),
            for: .normal)
        m14.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m14)),
            for: .normal)
        m21.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m21)),
            for: .normal)
        m22.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m22)),
            for: .normal)
        m23.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m23)),
            for: .normal)
        m24.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m24)),
            for: .normal)
        m31.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m31)),
            for: .normal)
        m32.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m32)),
            for: .normal)
        m33.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m33)),
            for: .normal)
        m34.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m34)),
            for: .normal)
        m41.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m41)),
            for: .normal)
        m42.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m42)),
            for: .normal)
        m43.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m43)),
            for: .normal)
        m44.setAttributedTitle(
            NSAttributedString(string: String(format: "%.3f", newTransform.m44)),
            for: .normal)
    }
    
    func showTransformParameters() {
        switchButton.setTitle("Show Values", for: .normal)
        m11.setAttributedTitle(
            ThreeDimensionMatrixUnit.m11.attributedString(),
            for: .normal)
        m12.setAttributedTitle(
            ThreeDimensionMatrixUnit.m12.attributedString(),
            for: .normal)
        m13.setAttributedTitle(
            ThreeDimensionMatrixUnit.m13.attributedString(),
            for: .normal)
        m14.setAttributedTitle(
            ThreeDimensionMatrixUnit.m14.attributedString(),
            for: .normal)
        m21.setAttributedTitle(
            ThreeDimensionMatrixUnit.m21.attributedString(),
            for: .normal)
        m22.setAttributedTitle(
            ThreeDimensionMatrixUnit.m22.attributedString(),
            for: .normal)
        m23.setAttributedTitle(
            ThreeDimensionMatrixUnit.m23.attributedString(),
            for: .normal)
        m24.setAttributedTitle(
            ThreeDimensionMatrixUnit.m24.attributedString(),
            for: .normal)
        m31.setAttributedTitle(
            ThreeDimensionMatrixUnit.m31.attributedString(),
            for: .normal)
        m32.setAttributedTitle(
            ThreeDimensionMatrixUnit.m31.attributedString(),
            for: .normal)
        m33.setAttributedTitle(
            ThreeDimensionMatrixUnit.m33.attributedString(),
            for: .normal)
        m34.setAttributedTitle(
            ThreeDimensionMatrixUnit.m34.attributedString(),
            for: .normal)
        m41.setAttributedTitle(
            ThreeDimensionMatrixUnit.m41.attributedString(),
            for: .normal)
        m42.setAttributedTitle(
            ThreeDimensionMatrixUnit.m42.attributedString(),
            for: .normal)
        m43.setAttributedTitle(
            ThreeDimensionMatrixUnit.m43.attributedString(),
            for: .normal)
        m44.setAttributedTitle(
            ThreeDimensionMatrixUnit.m44.attributedString(),
            for: .normal)
    }
    
    //MARK: SWITCH BUTTON
    private func addSwitchButton() {
        addSubview(switchButton)
        addConstraints(
            NSLayoutConstraint.addVisualConstraints("H:|-[v0]-|", views: switchButton)
        )
        addConstraints([
            switchButton.topAnchor.constraint(equalTo: m41.bottomAnchor, constant: 5),
            switchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            ])
        switchButton.addTarget(self,
                               action: #selector(switchButtonPressed),
                               for: .touchUpInside)
    }
    
    @objc func switchButtonPressed() {
        if isShowingValues {
            showTransformParameters()
        } else {
            showTransformValues()
        }
        
        isShowingValues = !isShowingValues
    }
    
    //MARK: SLIDER
    private func addSlider() {
        addSubview(slider)
        slider.isHidden = true
        DispatchQueue.main.async {
            self.slider.frame = self.switchButton.frame
        }
        slider.addTarget(self,
                         action: #selector(sliderValueChanged(_:)),
                         for: .valueChanged)
    }
    
    @objc private func sliderValueChanged(_ slider: UISlider) {
        if let button = selectedMButton {
            let value = slider.value
            ADDebug.printer(String(format: "%.3f", value))
            ADDebug.printer("BUTTON : \(button)")
            button.setAttributedTitle(NSAttributedString(string: String(format: "%.3f", value)), for: .normal)
            switch button {
            case m11:
                newTransform.m11 = CGFloat(value)
            case m12:
                newTransform.m12 = CGFloat(value)
            case m13:
                newTransform.m13 = CGFloat(value)
            case m14:
                newTransform.m14 = CGFloat(value)
            case m21:
                newTransform.m21 = CGFloat(value)
            case m22:
                newTransform.m22 = CGFloat(value)
            case m23:
                newTransform.m23 = CGFloat(value)
            case m24:
                newTransform.m24 = CGFloat(value)
            case m31:
                newTransform.m31 = CGFloat(value)
            case m32:
                newTransform.m32 = CGFloat(value)
            case m33:
                newTransform.m33 = CGFloat(value)
            case m34:
                newTransform.m34 = CGFloat(value)
            case m41:
                newTransform.m41 = CGFloat(value)
            case m42:
                newTransform.m42 = CGFloat(value)
            case m43:
                newTransform.m43 = CGFloat(value)
            case m44:
                newTransform.m44 = CGFloat(value)
            default:
                break;
            }
        }
        
        delegate?.applyTransformation(newTransform)
    }
    
    
    func applyTransform(_ transform: CATransform3D) {
        self.newTransform = transform
        if isShowingValues {
            showTransformValues()
        } else {
            showTransformParameters()
        }
        
        // If slider was shown, then set the value to the proper value based on the button's text
        if let buttonSelected = selectedMButton, let text = buttonSelected.attributedTitle(for: .normal),
            let value = Float(text.string) {
            slider.setValue(value, animated: true)
        }
    }
}

enum ThreeDimensionMatrixUnit: String {
    case
    m11, m12, m13, m14,
    m21, m22, m23, m24,
    m31, m32, m33, m34,
    m41, m42, m43, m44
    
    func attributedString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self.rawValue)
        attributedString.addAttribute(.baselineOffset, value: -12, range: NSRange(location: 1, length: 2))
        return attributedString as NSAttributedString
    }
}

extension NSLayoutConstraint {
    class func addVisualConstraints(_ format: String, views: UIView ...) -> [NSLayoutConstraint] {
        var dictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            dictionary[key] = view
        }
        return constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary)
    }
}

class SliderView: UIView {
    
}

class ValueSlider: UISlider {
//    override var value: Float {
//        didSet {
//            setThumbImage(SliderImage.marker.imageWith("\(value)"), for: .normal)
//        }
//    }
    
//    override func thumbImage(for state: UIControlState) -> UIImage? {
//        return UIImage(named: "marker")
//    }
}

enum SliderImage {
    case marker
    
    func imageWith(_ message: String) -> UIImage? {
        
        var image: UIImage?
        
        switch self {
        case .marker:
            image = #imageLiteral(resourceName: "marker")
        }
        
        // Create UIGraphic
        guard let newImage = image else {
            return image
        }
        
        return drawText(message, inImage: newImage, atPoint: CGPoint(x: 0, y: 0), to: CGSize(width: 20, height: 40))
    }
}

// https://stackoverflow.com/a/28907826/9795114
func drawText(_ text: String, inImage image: UIImage, atPoint point: CGPoint, to size: CGSize? = nil) -> UIImage? {
    let textColor = UIColor.white
    let textFont = UIFont.systemFont(ofSize: 12)
    
    // Setup the image context using the passed image
    let scale = UIScreen.main.scale
    
    var finalSize = image.size
    if let size = size {
        finalSize = size
    }
    
    UIGraphicsBeginImageContextWithOptions(finalSize, false, scale)
    
    let textAttr = [
        NSAttributedStringKey.font: textFont,
        NSAttributedStringKey.foregroundColor: textColor
    ]  as [NSAttributedStringKey : Any]
    
    // Put the image into a rectangle as large as the original image
    image.draw(in: CGRect(origin: .zero, size: image.size))
    
    let rect = CGRect(origin: point, size: image.size)
    text.draw(in: rect, withAttributes: textAttr)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}
