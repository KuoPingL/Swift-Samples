//
//  ColorPickerViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ColorPickerViewController: UIViewController {
    
    public weak var delegate: ColorPickerDelegate? = nil
    
    private let SLIDER_STEPS: Float = 255
    
    private lazy var colorValueLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var labelDisappearanceTimer: Timer?
    
    private lazy var closeButton: CloseButton = {
        let b = CloseButton(type: .roundedRect)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 20
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(tapToClose(_:)), for: .touchUpInside)
        b.backgroundColor = .white
        return b
    }()
    
    private lazy var backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderWidth = 2.0
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()
    
    private var rgbSliderViewController = RGBColorSliderViewController()
    
    public var selectedColor: UIColor = .white {
        didSet {
            rgbSliderViewController.selectedColor = selectedColor
        }
    }
    
    
    private var tapToCloseGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapToCloseGesture = UITapGestureRecognizer(target: self, action: #selector(tapToClose(_:)))
        view.addGestureRecognizer(tapToCloseGesture)
        setupUI()
    }
    
    @objc private func tapToClose(_ sender: NSObject) {
        if let gesture = sender as? UIGestureRecognizer {
            let tapLocation = gesture.location(in: view)
            if tapLocation.isInside(view: backgroundView) {
                return
            }
        } else if let button = sender as? UIButton, button != closeButton {
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        // Add backgroundView
        view.addSubview(backgroundView)
        // Add closeButton
        view.addSubview(closeButton)
        
        addChild(rgbSliderViewController)
        guard let rgbSliderView = rgbSliderViewController.view else {
            return
        }
        backgroundView.addSubview(rgbSliderView)
        rgbSliderViewController.delegate = delegate
        rgbSliderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints([
            closeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: -20),
            closeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
            ])
        
        backgroundView.addConstraints([
            rgbSliderView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            rgbSliderView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            rgbSliderView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            rgbSliderView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, constant: 0)
            ])
    }
}

extension ColorPickerViewController: ColorPickerDelegate {
    func didSelect(color: UIColor) {
        delegate?.didSelect(color: color)
    }
}
