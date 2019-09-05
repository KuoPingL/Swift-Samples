//
//  SimpleDialogInputView.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol SimpleDialogInputViewDelegate: AnyObject {
    func sendMessage(_ message: String)
}

class SimpleDialogInputView: UIView {
    
    public var nonactivated_placeholder = "Aa"
    public var activated_placeholder = "_enter_text".localized
    public var maximumNumberOfLines = 4
    public var textViewDelegate: UITextViewDelegate?
    public weak var delegate: SimpleDialogInputViewDelegate?
    
    private lazy var textView: UITextView = {
        let v = UITextView()
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        v.font = UIFont.systemFont(ofSize: 20)
        v.delegate = self
        v.bounces = false
        v.isScrollEnabled = false
        v.contentInset = .zero
        v.textContainerInset = UIEdgeInsets(top: v.textContainerInset.top, left: 10, bottom: v.textContainerInset.bottom, right: 20)
        return v
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
    
    private lazy var sendButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        b.setImage(UIImage.microphone, for: .normal)
        b.backgroundColor = .clear
        return b
    }()
    
    @objc private func buttonPressed(_ sender: UIButton) {
        if !textView.text.isEmpty {
            delegate?.sendMessage(textView.text)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: self.bounds.width, height: textView.bounds.height + 20)
        }
    }
    
    private lazy var containerView: UIView = {
//        let v = UIView()
        return self
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init(coder:) not implemented")
    }
    
    private func setupUI() {
        backgroundColor = .yellow
        textView
            .attachTo(view: containerView, with: .side(.left(inset: .init(top: 0, left: 10, bottom: 0, right: 0))))
            .attachTo(view: containerView, with: .side(.bottom(inset: .init(top: 0, left: 0, bottom: -10, right: 0))))
            .attachTo(view: containerView, with: .side(.top(inset: .init(top: 10, left: 0, bottom: 0, right: 0))))
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 40)
        textViewHeightConstraint?.isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeholderLabel)
        
        sendButton.attachTo(view: containerView, with: .side(.right(inset: .init(top: 0, left: 0, bottom: 0, right: -10))))
        
        [
            placeholderLabel.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: 20),
            placeholderLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            placeholderLabel.heightAnchor.constraint(equalToConstant: 40),
            sendButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.leftAnchor.constraint(equalTo: textView.rightAnchor, constant: 10),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.0),
            ].forEach({$0.isActive = true})
    }
}

extension SimpleDialogInputView: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        textViewDelegate?.textViewDidChangeSelection?(textView)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return textViewDelegate?.textViewShouldEndEditing?(textView) ?? true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return textViewDelegate?.textViewShouldEndEditing?(textView) ?? true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textViewDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return textViewDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return textViewDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true
    }
    
    
    enum TextViewDelegateActions {
        case didChange
        case didEndEditing
        case didBeginEditing
    }
    
    func textViewDidChange(_ textView: UITextView) {
        togglePlaceHolder()
        toggleTextViewConstraint(textViewDelegateAction: .didChange)
        textViewDelegate?.textViewDidChange?(textView)
        sendButton.setImage(textView.text.isEmpty ? UIImage.microphone : UIImage.send, for: .normal)
    }
    
    private func togglePlaceHolder() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        togglePlaceHolder()
        toggleTextViewConstraint(textViewDelegateAction: .didEndEditing)
        textViewDelegate?.textViewDidEndEditing?(textView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        toggleTextViewConstraint(textViewDelegateAction: .didBeginEditing)
        textViewDelegate?.textViewDidBeginEditing?(textView)
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
        setNeedsLayout()
    }
}

