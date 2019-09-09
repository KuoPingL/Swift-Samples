//
//  SimpleChatRoomTextViewAsAccessoryView.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/9/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatRoomTextViewAsAccessoryView: UIViewController {
    // Public VAR
    public var delegate: SimpleChatRoomLogDelegate!
    
    public lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.keyboardDismissMode = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        return tv
    }()
    
    private var users: [UserModel] = UserModel.sample()
    
    // Use to determine if user is currently the sender or receiver
    private var isSender = true
    
    // Record keyboard frame
    private var keyboardFrame: CGRect = .zero
    
    private lazy var customizedInputView: UIView = {
        return SimpleTextViewInputView(frame: .zero, delegate: self)
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return customizedInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = SimpleChatRoomLogDelegate(tableView: self.tableView, delegate: self)
        tableView.panGestureRecognizer.addTarget(self, action: #selector(tableViewPanGestureDetected(_:)))
        prepareUI()
    }
    
    @objc func tableViewPanGestureDetected(_ panGesture: UIPanGestureRecognizer) {
        guard let simpleTextViewInputView = inputAccessoryView as? SimpleTextViewInputView else {
            return
        }
        
        if let view = panGesture.view, view == tableView, panGesture.location(in: inputAccessoryView).y >= 0 {
            simpleTextViewInputView.textView.resignFirstResponder()
        }
    }
    
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView
            .top.equalTo(view.top_safeAreaLayoutGuid)
            .right.equalTo(view.right_safeAreaLayoutGuide)
            .left.equalTo(view.left_safeAreaLayoutGuide)
            .bottom.equalTo(view.bottom_safeAreaLayoutGuide)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardListener()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: customizedInputView.frame.height, right: 0)
    }
    
    private func addKeyboardListener() {
        self.addObserveKeyboardWillShow(with: #selector(keyboardListener(_:)), object: nil)
        self.addObserveKeyboardWillHide(with: #selector(keyboardListener(_:)), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeObserveKeyboardWillHide(object: nil)
        self.removeObserveKeyboardWillShow(object: nil)
    }
    
    @objc func keyboardListener(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardEndFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        // Since willHide will never be called when canBecomeFirstResponder = true
        keyboardFrame = keyboardEndFrame.cgRectValue
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
        let inputViewInitialHeight = customizedInputView.frame.height
        customizedInputView.layoutIfNeeded()
        let inputViewNewHeight = customizedInputView.frame.height
        let heightChanged = inputViewNewHeight - inputViewInitialHeight
        
        // change contentInset of tableview to take into account of the extra height from inputView
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + heightChanged, right: 0)
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset
        // we also need to consider the contentOffset of tableView
        // so we will face 3 conditions :
        // 1. inputView does not overlap or intercept with the tableView content
        // 2. inputView partially overlapping the tableView content
        // 3. inputView completely overlapping the tableView content
        
        //MARK: Calculate the proper contentOffset
        let overlappingRect = customizedInputView.convert(customizedInputView.frame, to: tableView)
        var visibleRect = overlappingRect
        
        // First Condition : inputView did not intercept with the tableView content
        if overlappingRect.minY > tableView.contentSize.height {
            return
        }
        
        if overlappingRect.maxY > tableView.contentSize.height {
            // Second Condition : inputView is partially overlapping the tableView content
            // Since it is only partially overlapped, so there will only be a small portion below the inputView and we want to show the whole content to user.
            
            visibleRect.size
                = CGSize(width: visibleRect.width,
                         height: tableView.contentSize.height - overlappingRect.minY)
        } else {
            // Third Condition : inputView is completely overlapping the tableView content
            // Here we also have 2 conditions :
            // 1. the tableView.contentSize is partially overlapping with the keyboard, which is right below the inputView
            // 2. the tableView.contentSize is completely overlapping with the keyboard and the tableView.contentSize might have greater height than the tableView.bounds.
            
            // First Condition : Keyboard + inputView is partially overlapping with tableView's content
            if overlappingRect.maxY + keyboardFrame.height > tableView.contentSize.height {
                visibleRect.size
                    = CGSize(width: visibleRect.size.width,
                             height: tableView.contentSize.height - overlappingRect.minY)
            } else {
                // Second Condition : Keyboard + inputView is completely overlapping with tableView's content
                visibleRect.size
                    = CGSize(width: visibleRect.size.width,
                             height: keyboardFrame.height + heightChanged - inputViewInitialHeight)
            }
        }
        
        tableView.scrollRectToVisible(visibleRect, animated: true)
        
        
        /* NOTE :
         feel free to switch to the code below :
         // 0.25 duration is the standard keyboard animation duration
         
         UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
         self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.contentOffset.y + visibleRect.height)
         }.startAnimation()
         
         it has the same effect as scrollRectToVisible.
         */
    }
    
    func textViewDidChange() {
        // when the text changes, the customizedInputView might grow or shrink.
        let inputViewInitialHeight = customizedInputView.frame.height
        customizedInputView.layoutIfNeeded()
        let inputViewNewHeight = customizedInputView.frame.height
        let heightChanged = inputViewNewHeight - inputViewInitialHeight
        
        let overlappingRect = customizedInputView.convert(customizedInputView.frame, to: tableView)
        
        // Grow if heightChanged > 0 vice versa
        // Similar to didBeginEditing, we need to adjust the contentInset and contentOffset. Also, here we don't need to consider the keyboardFrame or the customizedInputView height, we only need the heightChanged, current contentInset and contentOffset.
        
        tableView.contentInset
            = UIEdgeInsets(
                top: tableView.contentInset.top,
                left: tableView.contentInset.left,
                bottom: tableView.contentInset.bottom + heightChanged,
                right: tableView.contentInset.right)
        tableView.scrollIndicatorInsets = tableView.contentInset
        // So there are also different situations here :
        // 1. the heightChanged portion does not overlap with tableView's content
        // 2. the heightChanged portion does overlap with tableView's content
        let contentOffset = self.tableView.contentOffset
        var newContentOffset = CGPoint(x: contentOffset.x,
                      y: contentOffset.y + heightChanged)
        
        if newContentOffset.y < 0 || heightChanged == 0 {return}
        
        if heightChanged > 0 {
            // Growing
            if overlappingRect.minY > self.tableView.contentSize.height {
                return
            }
        } else {
            // Shrinking
            let distanceBetweenContentAndInputView = self.tableView.contentSize.height - overlappingRect.minY
            if heightChanged > distanceBetweenContentAndInputView {
                newContentOffset = CGPoint(x: contentOffset.x,
                                           y: contentOffset.y + distanceBetweenContentAndInputView)
            }
        }
        
        
        UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.tableView.contentOffset
                = newContentOffset
        }.startAnimation()
    }
    
    func textViewDidEndEditing() {
        // when ended, the textView will resignFirstReponder, meaning the keyboard should now be hidden
        customizedInputView.layoutIfNeeded()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: customizedInputView.frame.height, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}

