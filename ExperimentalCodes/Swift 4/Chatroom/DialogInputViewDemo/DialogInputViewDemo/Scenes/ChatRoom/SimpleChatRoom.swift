//
//  ChatRoom.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatRoom: UIViewController {
    //MARK: - Public VAR
    
    public var delegate: SimpleChatRoomLogDelegate!
    
    public lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.keyboardDismissMode = .interactive
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        return tv
    }()
    
    public var users: [UserModel] = UserModel.sample()
    
    // Use to determine if user is currently the sender or receiver
    public var isSender = true
    
    
    // Record keyboard frame
    public var keyboardFrame: CGRect = .zero
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = SimpleChatRoomLogDelegate(tableView: self.tableView, delegate: self)
        tableView.panGestureRecognizer.addTarget(self, action: #selector(tableViewPanGestureDetected(_:)))
        prepareUI()
    }
    
    @objc public func tableViewPanGestureDetected(_ panGesture: UIPanGestureRecognizer) {
        
    }
    
    
    public var customizedInputViewObserver: NSKeyValueObservation?
    
    public func prepareUI() {
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardListener()
    }
    
    private func addKeyboardListener() {
        self.addObserveKeyboardWillShow(with: #selector(keyboardListener(_:)), object: nil)
        self.addObserveKeyboardWillHide(with: #selector(keyboardListener(_:)), object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardListener()
    }
    
    private func removeKeyboardListener() {
        self.removeObserveKeyboardWillHide(object: nil)
        self.removeObserveKeyboardWillShow(object: nil)
    }
    
    @objc public func keyboardListener(_ notification: Notification) {
    }
}
