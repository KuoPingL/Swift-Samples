//
//  SimpleTextViewInputView.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleTextViewInputView: InputBaseView {
    
    public weak var delegate: SimpleInputViewDelegate?
    
    public var maximumNumberOfLines = 3
    
    public var isEditing = false
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.bounds.width, height: self.textView.bounds.height + 20)
    }
    
    private var textViewMaximumHeight: CGFloat = 0
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.bounces = false
        tv.isScrollEnabled = false
        tv.contentInset = .zero
        tv.textContainerInset = UIEdgeInsets(top: tv.textContainerInset.top, left: 10, bottom: tv.textContainerInset.bottom, right: 20)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.contentInsetAdjustmentBehavior = .never
        tv.scrollIndicatorInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return tv
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "_placeholder".localized
        l.textColor = UIColor.lightGray
        l.backgroundColor = .clear
        return l
    }()
    
    private lazy var textViewContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 22
        v.layer.masksToBounds = true
        v.backgroundColor = textView.backgroundColor
        return v
    }()
    
    private lazy var sendButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("_send".localized, for: .normal)
        b.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return b
    }()
    
    @objc func sendMessage() {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            return
        } else {
            isEditing = false
            delegate?.send(message: textView.text)
            textView.text = ""
            textViewDidChange(textView)
        }
    }
    
    private lazy var textViewHeightSnap: SimpleSnap = {
        return textView.height
    }()
    
    init(frame: CGRect, delegate: SimpleInputViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        prepareUI()
    }
    
    public func setTextViewEndEditing() {
        toggleTextViewHeight(.didEndEditing)
    }
    
    override func prepareUI() {
        super.prepareUI()
        addSubview(textViewContainerView)
        textViewContainerView.addSubview(textView)
        addSubview(sendButton)
        addSubview(placeholderLabel)
        
        textView
            .edgeTo(textViewContainerView, with: UIEdgeInsets(top: 1, left: 10, bottom: -1, right: -20))
        
        textViewContainerView
            .top.equalTo(self.top_safeAreaLayoutGuid, constant: 10)
            .bottom.equalTo(self.bottom_safeAreaLayoutGuide, constant: -10)
            .leading.equalTo(self.leading_safeAreaLayoutGuide, constant: 10)
            .trailing.equalTo(sendButton.leading, constant: -10)
        
        textViewHeightSnap.equalTo(nil, constant: 40)
        
        sendButton
            .bottom.equalTo(textView.bottom)
            .trailing.equalTo(self.trailing_safeAreaLayoutGuide, constant: -10)
        
        sendButton.sizeToFit()
        sendButton.width.equalTo(nil, constant: sendButton.frame.width)
        
        placeholderLabel
            .bottom.equalTo(textView.bottom)
            .height.equalTo(textView.height)
            .leading.equalTo(textView.leading, constant: 20)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init(coder:) is not implemented")
    }
}

//MARK:- UITextViewDelegate
extension SimpleTextViewInputView: UITextViewDelegate {
    
    enum TextViewActions {
        case didBeginEditing
        case didChange
        case didEndEditing
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        toggleTextViewHeight(.didBeginEditing)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !text.isEmpty {
            isEditing = true
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        toggleTextViewHeight(.didChange)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        isEditing = true
        toggleTextViewHeight(.didEndEditing)
    }
    
    func toggleTextViewHeight(_ action: TextViewActions) {
        switch action {
        case .didBeginEditing,
             .didChange:
            
            placeholderLabel.isHidden = !textView.text.isEmpty
            textView.textContainer.lineBreakMode = .byWordWrapping
            let currentSize = CGSize(width: textView.bounds.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(currentSize)
            let contentHeight = estimatedSize.height - textView.textContainerInset.top - textView.textContainerInset.bottom
            let numberOfLines = Int(contentHeight / textView.font!.lineHeight)
            
            textView.isScrollEnabled = numberOfLines > maximumNumberOfLines
            if numberOfLines <= maximumNumberOfLines {
                if estimatedSize.height > textViewMaximumHeight {
                    textViewMaximumHeight = estimatedSize.height
                }
                textViewHeightSnap.constant = estimatedSize.height
            } else {
                textViewHeightSnap.constant = textViewMaximumHeight
            }
            
            if (action == .didBeginEditing) {
                delegate?.textViewDidBeginEditing()
                if self.textView.isScrollEnabled {
                    self.textView.contentOffset = CGPoint(x: 0, y: self.textView.contentSize.height - self.textView.bounds.height)
                    textView.layoutIfNeeded()
                }
                DispatchQueue.main.async {
                    self.textView.selectedRange.location = self.textView.text.count
                }
            } else {
                delegate?.textViewDidChange()
            }
            break;
        case .didEndEditing:
            textView.isScrollEnabled = false
            textViewHeightSnap.constant = 40
            textView.textContainer.lineBreakMode = .byTruncatingTail
            delegate?.textViewDidEndEditing()
            break;
        }
    }
}
