//
//  SimpleTextFieldInputView.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleTextFieldInputView: UIView {
    public weak var delegate: SimpleInputViewDelegate?
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: self.bounds.width, height: self.textField.bounds.height + 20)
        }
    }
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 20
        tf.layer.masksToBounds = true
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "_placeholder".localized
        tf.delegate = self
        return tf
    }()
    
    private lazy var sendButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("_send".localized, for: .normal)
        b.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return b
    }()
    
    @objc func sendMessage() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        delegate?.send(message: textField.text!)
    }
    
    init(frame: CGRect, delegate: SimpleInputViewDelegate) {
        super.init(frame: frame)
        addSubview(textField)
        addSubview(sendButton)
        
        textField
            .top.equalTo(self.top, constant: 10)
            .bottom.equalTo(self.bottom, constant: -10)
            .leading.equalTo(self.leading, constant: 10)
            .height.equalTo(nil, constant: 40)
        
        sendButton
            .bottom.equalTo(textField.bottom)
            .leading.equalTo(textField.leading, constant: 10)
            .trailing.equalTo(self.trailing, constant: -10)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init(coder:) is not implemented")
    }
}

extension SimpleTextFieldInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
