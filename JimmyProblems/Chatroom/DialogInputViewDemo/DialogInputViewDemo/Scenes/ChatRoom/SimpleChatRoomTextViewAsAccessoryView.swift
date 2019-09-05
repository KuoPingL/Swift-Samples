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
    private var isInputViewEditing: Bool = false
    
    private var inputViewInitialHeight: CGFloat = 0
    
    override func tableViewPanGestureDetected(_ panGesture: UIPanGestureRecognizer) {
        if let view = panGesture.view, view == tableView, let simpleTextViewInputView = inputAccessoryView as? SimpleTextViewInputView, panGesture.location(in: inputAccessoryView).y >= 0 {
            simpleTextViewInputView.setTextViewEndEditing()
        }
    }
    
    override func prepareUI() {
        super.prepareUI()
        view.addSubview(tableView)
        tableView
            .top.equalTo(view.top_safeAreaLayoutGuid)
            .right.equalTo(view.right_safeAreaLayoutGuide)
            .left.equalTo(view.left_safeAreaLayoutGuide)
            .bottom.equalTo(view.bottom_safeAreaLayoutGuide)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: customizedInputView.frame.height, right: 0)
        inputViewInitialHeight = customizedInputView.frame.height
        customizedInputViewObserver = customizedInputView.observe(\.bounds, options: [.new, .old], changeHandler: { (view, value) in
            
            if let inputView = self.customizedInputView as? SimpleTextViewInputView {
                // TableView will take care of scrolling right after receiving message
                // So nothing should be done here.
                if (inputView.isEditing) {
                    guard let newBound = value.newValue, let oldBound = value.oldValue else {
                        return
                    }
                    
                    var deltaHeight = newBound.height - oldBound.height
                    
                    let inputViewToTableViewRect = self.customizedInputView.convert(self.customizedInputView.bounds, to: self.tableView)
                    
                    if deltaHeight > 0 && inputViewToTableViewRect.minY > self.tableView.contentSize.height {
                        // if the inputView will not overlap with the tableView's content, then nothing needs to be done.
                        return
                    }
                    
                    if self.tableView.contentOffset.y + deltaHeight < 0 {
                        // The tableView should not have a negative offset.y when the inputView is shrinking.
                        return
                    }
                    
                    if inputViewToTableViewRect.maxY > self.tableView.contentSize.height && (deltaHeight > 0 && (self.tableView.contentSize.height - inputViewToTableViewRect.minY) < deltaHeight) {
                        // If correspondingRect is only partially overlapping with tableView's Content, only that portion should be offset.
                        // However, this only occur when deltaHeight > 0 (when inputView is growing)
                        deltaHeight = self.tableView.contentSize.height - inputViewToTableViewRect.minY
                    }
                    DispatchQueue.main.async {
                        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: self.tableView.contentOffset.y + deltaHeight)
                    }
                }
            }
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        customizedInputViewObserver?.invalidate()
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
    
    private var testView: UIView = UIView()
    private var test2View: UIView = UIView()
}

//MARK: - SimpleInputViewDelegate
extension SimpleChatRoomTextViewAsAccessoryView: SimpleInputViewDelegate {
    func send(message: String) {
        isInputViewEditing = false
        print("==== DONE END =====")
        let model = SimpleChatModel(message: message, image: nil, isSent: true, sender: isSender ? users[0] : users[1], isSender: isSender)
        delegate.appendMessage(model)
        isSender.toggle()
    }
    
    func textViewDidBeginEditing() {
        
        let previousInputViewHeight = customizedInputView.frame.height
        // AutoLayout customizedInputView
        customizedInputView.layoutIfNeeded()
        let currentInputViewHeight = customizedInputView.frame.height
        let inputViewDeltaHeight = currentInputViewHeight - previousInputViewHeight
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardFrame.height + ((inputViewDeltaHeight > 0) ? inputViewDeltaHeight : 0), right: 0)
        self.tableView.contentInset = contentInset
        self.tableView.scrollIndicatorInsets = contentInset
        
        
        // Calculate the origin of the rect to be visible
        var visibleOriginY = tableView.frame.height - currentInputViewHeight + tableView.contentOffset.y
        
        var visibleHeight: CGFloat = currentInputViewHeight
        
        if visibleOriginY > tableView.contentSize.height {
            // This means the inputView will either block a small portion of the tableview or nothing at all
            visibleHeight = tableView.contentSize.height - tableView.contentOffset.y - (keyboardFrame.minY - currentInputViewHeight)
            visibleOriginY = tableView.contentSize.height - visibleHeight
        }
        
        var overLapRect = customizedInputView.convert(customizedInputView.bounds, to: tableView)
        if overLapRect.origin.y > tableView.contentSize.height {return}
        
        if overLapRect.maxY > tableView.contentSize.height {
            // if the inputView is partially intercept with the tableView's content
            
            overLapRect.size = CGSize(width: overLapRect.width, height: tableView.contentSize.height - overLapRect.minY)
            
        } else if overLapRect.maxY < tableView.contentSize.height {
            // if the inputView is completely located within the tableView's content
            var hiddenHeight =  tableView.contentSize.height - tableView.contentOffset.y - tableView.bounds.height
            if hiddenHeight < 0 {
                hiddenHeight = 0
            }
            
            var expectedHeight = tableView.contentSize.height - overLapRect.minY - hiddenHeight
            
            if hiddenHeight > 0 {
                expectedHeight -= overLapRect.height
            }
            
            overLapRect.size = CGSize(width: overLapRect.width, height: expectedHeight)
        }
        
        tableView.scrollRectToVisible(overLapRect, animated: true)
    }
    
    func textViewDidEndEditing() {
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: customizedInputView.frame.height, right: 0)
        self.tableView.contentInset = contentInset
        self.tableView.scrollIndicatorInsets = contentInset
    }
}

