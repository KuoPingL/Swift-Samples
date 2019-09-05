//
//  RGBColorSliderViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class RGBColorSliderViewController: UIViewController {
    public weak var delegate: ColorPickerDelegate? = nil
    
    private let SLIDER_STEPS: Float = 255
    
    private lazy var colorValueLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        return l
    }()
    
    private lazy var sliderStack: UIStackView = {
        let s = UIStackView(frame: .zero)
        s.alignment = .leading
        s.distribution = .fill
        s.axis = .vertical
        s.translatesAutoresizingMaskIntoConstraints = false
        s.spacing = 10
        return s
    }()
    
    private lazy var rSlider: UISlider = {
        let s = UISlider(frame: .zero)
        s.maximumValue = 255
        s.minimumValue = 0
        s.thumbTintColor = .red
        s.translatesAutoresizingMaskIntoConstraints = false
        s.setValue(127, animated: false)
        s.addTarget(self, action: #selector(sliderDidSlide(_:)), for: .valueChanged)
        return s
    }()
    private lazy var gSlider: UISlider = {
        let s = UISlider(frame: .zero)
        s.maximumValue = 255
        s.minimumValue = 0
        s.thumbTintColor = .green
        s.translatesAutoresizingMaskIntoConstraints = false
        s.setValue(127, animated: false)
        s.addTarget(self, action: #selector(sliderDidSlide(_:)), for: .valueChanged)
        return s
    }()
    private lazy var bSlider: UISlider = {
        let s = UISlider(frame: .zero)
        s.maximumValue = 255
        s.minimumValue = 0
        s.thumbTintColor = .blue
        s.translatesAutoresizingMaskIntoConstraints = false
        s.setValue(127, animated: false)
        s.addTarget(self, action: #selector(sliderDidSlide(_:)), for: .valueChanged)
        return s
    }()
    
    public var selectedColor: UIColor = .white {
        didSet {
            guard let colorComponents = selectedColor.cgColor.components else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.rSlider.setValue(Float(colorComponents[0]) * (self?.SLIDER_STEPS ?? 0), animated: true)
                self?.gSlider.setValue(Float(colorComponents[1]) * (self?.SLIDER_STEPS ?? 0), animated: true)
                self?.bSlider.setValue(Float(colorComponents[2]) * (self?.SLIDER_STEPS ?? 0), animated: true)
                self?.displayRGBValues()
            }
        }
    }
    
    @objc private func sliderDidSlide(_ sender: UISlider) {
        // Display sliderValue Int in colorValueLabel
        displayRGBValues()
        // Display resulted color in colorDisplay
        let r = CGFloat(rSlider.value / SLIDER_STEPS)
        let g = CGFloat(gSlider.value / SLIDER_STEPS)
        let b = CGFloat(bSlider.value / SLIDER_STEPS)
        delegate?.didSelect(color: UIColor(red: r, green: g, blue: b, alpha: 1.0))
    }
    
    private func displayRGBValues() {
        let r = Int(rSlider.value)
        let g = Int(gSlider.value)
        let b = Int(bSlider.value)
        colorValueLabel.text = "(R: \(r) G: \(g) B: \(b))"
        
        // once invalidate, timer cannot be reused
//        labelDisappearanceTimer?.invalidate()
//        labelDisappearanceTimer = nil
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.frame.size.height = sliderStack.frame.maxY + 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //Setup UI
    private func setupUI() {
        view.addSubview(colorValueLabel)
        sliderStack.addArrangedSubview(rSlider)
        sliderStack.addArrangedSubview(gSlider)
        sliderStack.addArrangedSubview(bSlider)
        
        sliderStack.addConstraints([
            rSlider.widthAnchor.constraint(equalTo: sliderStack.widthAnchor, multiplier: 1.0),
            gSlider.widthAnchor.constraint(equalTo: sliderStack.widthAnchor, multiplier: 1.0),
            bSlider.widthAnchor.constraint(equalTo: sliderStack.widthAnchor, multiplier: 1.0)
            ])
        
        view.addSubview(sliderStack)
        
        view.addConstraints(
            [
                colorValueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                colorValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                colorValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                sliderStack.topAnchor.constraint(equalTo: colorValueLabel.bottomAnchor, constant: 20),
                sliderStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                sliderStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ]
        )
    }
}
