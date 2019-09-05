//
//  DialogViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/18.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit



final class DialogViewController: UIViewController {
    
    public var nonactivated_placeholder = "Aa"
    public var activated_placeholder = "_enter_text".localized
    public var maximumNumberOfLines = 4
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 5
        sv.addArrangedSubview(showAdditionalButton)
        sv.addArrangedSubview(additionalButton)
        sv.addArrangedSubview(cameraButton)
        sv.addArrangedSubview(photoLibraryButton)
        return sv
    }()
    
    private lazy var showAdditionalButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        b.isHidden = true
        b.backgroundColor = .yellow
        return b
    }()
    
    private lazy var additionalButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        b.backgroundColor = .green
        return b
    }()
    
    private lazy var cameraButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        b.backgroundColor = .blue
        return b
    }()
    
    private lazy var photoLibraryButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        b.backgroundColor = .red
        return b
    }()
    
    private lazy var sendButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        b.setImage(UIImage.microphone, for: .normal)
        b.backgroundColor = .clear
        return b
    }()
    
    private lazy var stickerButton: StickerButton = {
        let b = StickerButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    @objc private func buttonPressed(_ sender: UIButton) {
        switch sender {
        case sendButton:
            break;
        case additionalButton:
            toggleAdditionalButtons()
            break;
        case showAdditionalButton:
            toggleAdditionalButtons()
            break;
        case cameraButton:
            break;
        case photoLibraryButton:
            break;
        case stickerButton:
            stickerButton.isSelected.toggle()
            if stickerButton.isSelected {
                stickerButton.becomeFirstResponder()
            } else {
                stickerButton.resignFirstResponder()
            }
            break;
        default:
            break;
        }
    }
    
    private func toggleAdditionalButtons() {
        showAdditionalButton.isHidden.toggle()
        additionalButton.isHidden.toggle()
        cameraButton.isHidden.toggle()
        photoLibraryButton.isHidden.toggle()
    }
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.delegate = self
        tv.layer.cornerRadius = 20
        tv.layer.masksToBounds = true
        tv.isScrollEnabled = false
        tv.bounces = false
        tv.textContainerInset = UIEdgeInsets(top: tv.textContainerInset.top, left: 20, bottom: tv.textContainerInset.bottom, right: 40)
        return tv
    }()
    private var textViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var placeholderLabel: UILabel = {
        let l = UILabel()
        l.text = nonactivated_placeholder
        l.font = textView.font
        l.textColor = UIColor.lightGray.withAlphaComponent(0.6)
        l.backgroundColor = .clear
        return l
    }()
    
    private var container: UIView = UIView()
    
    private var buttonStackViewWidth: CGFloat = 0
    private var buttonStackWidthConstraint: NSLayoutConstraint?
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var i = 0
        for arrangedSubview in buttonStackView.arrangedSubviews {
            i += arrangedSubview.isHidden ? 0 : 1
        }
        
        buttonStackWidthConstraint?.isActive = false
        
        buttonStackViewWidth = CGFloat(i * 40) + CGFloat(i - 1) * buttonStackView.spacing
        
        buttonStackWidthConstraint = buttonStackView.widthAnchor.constraint(equalToConstant: buttonStackViewWidth)
        buttonStackWidthConstraint?.isActive = true
    }
    private var textViewSizeObserver: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()
        container
            .attachTo(view: view, with: .side(.left(inset: .zero)))
            .attachTo(view: view, with: .side(.right(inset: .zero)))
            .attachTo(view: view, with: .side(.top(inset: .zero)))
        
        textView
            .attachTo(view: container, with: .side(.top(inset: .init(top: 10, left: 0, bottom: 0, right: 0))))
            .attachTo(view: container, with: .side(.bottom(inset: .init(top: 0, left: 0, bottom: -10, right: 0))))
        
        textViewHeightConstraint =  textView.heightAnchor.constraint(equalToConstant: 40)
        textViewHeightConstraint?.isActive = true
        container.heightAnchor.constraint(greaterThanOrEqualTo: textView.heightAnchor, multiplier: 1.0).isActive = true
        
        buttonStackView
            .attachTo(view: container, with: .side(.left(inset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))))
        
        buttonStackView.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
        
        stickerButton
            .attachTo(view: textView, with: .side(.right(inset: .init(top: 0, left: 0, bottom: 0, right: 0))))
            .attachTo(view: textView, with: .side(.bottom(inset: .zero)))
        
        stickerButton.widthAnchor.constraint(equalTo: stickerButton.heightAnchor, multiplier: 1.0).isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(placeholderLabel)
        
        [placeholderLabel.leftAnchor
            .constraint(equalTo: textView.leftAnchor, constant: 30),
        placeholderLabel.heightAnchor
            .constraint(equalToConstant: 40),
        placeholderLabel.bottomAnchor
            .constraint(equalTo: textView.bottomAnchor),
        placeholderLabel.heightAnchor
            .constraint(equalTo: stickerButton.heightAnchor, multiplier: 1.0)]
            .forEach({$0.isActive = true})
        
        sendButton
            .attachTo(view: container, with: .side(.right(inset: .zero)))
        
        [sendButton.bottomAnchor
            .constraint(equalTo: textView.bottomAnchor),
        sendButton.widthAnchor
            .constraint(equalToConstant: 40),
        sendButton.heightAnchor
            .constraint(equalTo: sendButton.widthAnchor, multiplier: 1.0),
        textView.rightAnchor
            .constraint(equalTo: sendButton.leftAnchor, constant: -10),
        textView.leftAnchor
            .constraint(equalTo: buttonStackView.rightAnchor, constant: 10)]
            .forEach({$0.isActive = true})
    }
}

extension DialogViewController: UITextViewDelegate {
    enum TextViewDelegateActions {
        case didChange
        case didEndEditing
        case didBeginEditing
    }
    
    func textViewDidChange(_ textView: UITextView) {
        togglePlaceHolder()
        toggleTextViewConstraint(textViewDelegateAction: .didChange)
    }
    
    private func togglePlaceHolder() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !showAdditionalButton.isHidden {
            toggleAdditionalButtons()
        }
        togglePlaceHolder()
        toggleTextViewConstraint(textViewDelegateAction: .didEndEditing)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if showAdditionalButton.isHidden {
            toggleAdditionalButtons()
        }
        toggleTextViewConstraint(textViewDelegateAction: .didBeginEditing)
    }
    
    private func toggleTextViewConstraint(textViewDelegateAction: TextViewDelegateActions) {
        
        let textView = self.textView
        switch textViewDelegateAction {
        case .didBeginEditing, .didChange:
            let size = CGSize(width: textView.frame.size.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(size)
            let numberOfLines = Int(estimatedSize.height / textView.font!.lineHeight)
            textView.isScrollEnabled = numberOfLines > maximumNumberOfLines
            if numberOfLines > maximumNumberOfLines {
                textViewHeightConstraint?.constant = CGFloat(self.maximumNumberOfLines) *  textView.font!.lineHeight + textView.textContainerInset.top + textView.textContainerInset.bottom
            } else {
                textViewHeightConstraint?.constant = estimatedSize.height
            }
            
            if textViewDelegateAction == .didBeginEditing {
                textView.setContentOffset(CGPoint(x: 0, y: textView.contentSize.height - textView.frame.height - textView.textContainerInset.top - textView.textContainerInset.bottom), animated: false)
                
                DispatchQueue.main.async {
                    self.textView.selectedRange.location = self.textView.text.count
                }
            }
        case .didEndEditing:
            textViewHeightConstraint?.constant = 40
            textView.isScrollEnabled = false
            textView.contentOffset = .zero
            textView.textContainer.lineBreakMode = .byTruncatingTail
        }
    }
}
