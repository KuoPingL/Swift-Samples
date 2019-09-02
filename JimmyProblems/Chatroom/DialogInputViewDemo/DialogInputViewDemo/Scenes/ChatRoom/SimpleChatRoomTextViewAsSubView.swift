//
//  SimpleChatRoomTextViewAsSubView.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/9/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatRoomTextViewAsSubView: SimpleChatRoom {
    internal lazy var customizedInputView: UIView = {
        return SimpleTextViewInputView(frame: .zero, delegate: self)
    }()
    
    override func tableViewPanGestureDetected(_ panGesture: UIPanGestureRecognizer) {
        
    }
    
    private var bottomSnap: SimpleSnap?
    
    override func prepareUI() {
        super.prepareUI()
        tableView
            .top.equalTo(view.top_safeAreaLayoutGuid)
            .right.equalTo(view.right_safeAreaLayoutGuide)
            .left.equalTo(view.left_safeAreaLayoutGuide)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: customizedInputView.frame.height, right: 0)
        
        view.addSubview(customizedInputView)
        customizedInputView
            .leading.equalTo(view.leading_safeAreaLayoutGuide)
            .trailing.equalTo(view.trailing_safeAreaLayoutGuide)
        
        bottomSnap = customizedInputView.bottom
        bottomSnap?.equalTo(view.bottom_safeAreaLayoutGuide)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.bottom.equalTo(customizedInputView.top)
        
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupObserver()
    }
    
    private func setupObserver() {
        customizedInputViewObserver = customizedInputView.observe(\.bounds, options: [.new, .old], changeHandler: { (view, value) in
            guard let newHeight = value.newValue?.height, let oldHeight = value.oldValue?.height else {
                return
            }
            if self.keyboardFrame.height == 0 {
                return
            }
            let heightDifference = newHeight - oldHeight
            self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.contentOffset.y + heightDifference)
        })
    }
    
    override func keyboardListener(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardEndFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        keyboardFrame = keyboardEndFrame.cgRectValue
        
        guard let duration = userInfo.value(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as? Double, let animationRaw = userInfo.value(forKey: UIResponder.keyboardAnimationCurveUserInfoKey) as? Int else {
            return
        }
        
        UIViewPropertyAnimator(duration: duration, curve: UIView.AnimationCurve(rawValue: animationRaw) ?? .easeInOut) {
            self.bottomSnap?.constant = -self.keyboardFrame.height
            }.startAnimation()
        if notification.name == UIResponder.keyboardWillHideNotification {
            return
        }
    }
    
}

//MARK: - SimpleInputViewDelegate
extension SimpleChatRoomTextViewAsSubView: SimpleInputViewDelegate {
    func send(message: String) {
        
        let model = SimpleChatModel(message: message, image: nil, isSent: true, sender: isSender ? users[0] : users[1], isSender: isSender)
        delegate.appendMessage(model)
        isSender.toggle()
    }
    
    func textViewDidBeginEditing() {
        if true {
            let visibleHeight = view.frame.size.height - (self.navigationController?.navigationBar.frame.height ?? 0) - customizedInputView.frame.height - keyboardFrame.height
            if tableView.contentSize.height <  visibleHeight {
                return
            }
            UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
                self.tableView.contentOffset = CGPoint(x: 0, y: self.keyboardFrame.height)
                }.startAnimation()
            return
        }
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

