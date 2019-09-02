//
//  SimpleChatRoomTextViewAsAccessoryView.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/9/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatRoomTextViewAsAccessoryView: SimpleChatRoom {
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private lazy var customizedInputView: UIView = {
        return SimpleTextViewInputView(frame: .zero, delegate: self)
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return customizedInputView
        }
    }
    
    private var bottomSnap: SimpleSnap?
    
    override func tableViewPanGestureDetected(_ panGesture: UIPanGestureRecognizer) {
        if let view = panGesture.view, view == tableView, let simpleTextViewInputView = inputAccessoryView as? SimpleTextViewInputView, panGesture.location(in: inputAccessoryView).y >= 0 {
            simpleTextViewInputView.setTextViewEndEditing()
        }
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        tableView
            .top.equalTo(view.top_safeAreaLayoutGuid)
            .right.equalTo(view.right_safeAreaLayoutGuide)
            .left.equalTo(view.left_safeAreaLayoutGuide)
            .bottom.equalTo(view.bottom_safeAreaLayoutGuide)
    }
    
    override func keyboardListener(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardEndFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        keyboardFrame = keyboardEndFrame.cgRectValue
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            
            keyboardFrame = keyboardEndFrame.cgRectValue
            
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            
            // This will never be called when SimpleChatRoom canBecomeFirstResponder
        }
    }
    private func received(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardEndFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        keyboardFrame = keyboardEndFrame.cgRectValue
        if notification.name == UIResponder.keyboardWillShowNotification {
            
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            
        }
    }
}

//MARK: - SimpleInputViewDelegate
extension SimpleChatRoomTextViewAsAccessoryView: SimpleInputViewDelegate {
    func send(message: String) {
        
        let model = SimpleChatModel(message: message, image: nil, isSent: true, sender: isSender ? users[0] : users[1], isSender: isSender)
        delegate.appendMessage(model)
        isSender.toggle()
    }
    
    func textViewDidBeginEditing() {
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardFrame.height + 0, right: 0)
        self.tableView.contentInset = contentInset
        self.tableView.scrollIndicatorInsets = contentInset
    }
    
    func textViewDidEndEditing() {
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.customizedInputView.frame.height, right: 0)
        self.tableView.contentInset = contentInset
        self.tableView.scrollIndicatorInsets = contentInset
    }
    
}

