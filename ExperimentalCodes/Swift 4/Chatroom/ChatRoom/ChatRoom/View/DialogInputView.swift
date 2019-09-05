//
//  DialogInputView.swift
//  ChatRoom
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

// idea 超好的
enum DialogInputViewBehavior {
    case didBeginEdit
    case didEndEdit
    case didChange
    case didPressExtraButton
    case didPressSentButton
}

enum InputTextViewStatus {
    case empty
    case filled
}

class DialogInputContainer: UIView {
    // Contains InputTextView, SentButton, ExtraButton
    static let DEFAULT_PLACEHOLDER_COLOR = UIColor(red: 99 / 255, green: 99 / 255, blue: 99 / 255, alpha: 1)
    static let DEFAULT_PLACEHOLDER = "輸入聊天內容"
    
    //MARK: Public Variables
    public var placeholder: String = DialogInputContainer.DEFAULT_PLACEHOLDER
    {
        didSet {
            if dialogInputViewStatus == .empty {
                dialogInputView.text = placeholder
            }
        }
    }
    
    public var dialogInputViewPlaceholderColor = DialogInputContainer.DEFAULT_PLACEHOLDER_COLOR
    {
        didSet {
            if dialogInputViewStatus == .empty {
                dialogInputView.textColor = dialogInputViewPlaceholderColor
            }
        }
    }
    
    public var dialogInputViewTextColor = UIColor.white
    {
        didSet {
            if dialogInputViewStatus == .filled {
                dialogInputView.textColor = dialogInputViewTextColor
            }
        }
    }
    
    private var dialogInputView = UITextView  {
        $0.backgroundColor = .clear
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isScrollEnabled = false
        $0.bounces = false
        $0.text = DialogInputContainer.DEFAULT_PLACEHOLDER
        $0.textColor = DialogInputContainer.DEFAULT_PLACEHOLDER_COLOR
        $0.textContainerInset = .zero
    }
    
    private var dialogInputViewStatus: InputTextViewStatus = .empty
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init(coder:) not been implemented")
    }
    
    private func commonInit() {
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)
        setViews()
    }
    
    private func setViews() {
        dialogInputView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dialogInputView)
        setConstraints()
    }
    
    private func setConstraints() {
        addConstraints([
            dialogInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dialogInputView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dialogInputView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            dialogInputView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
    }
    
}
