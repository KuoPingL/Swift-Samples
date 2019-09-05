//
//  ConversationViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/4.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class ConversationViewController: UITableViewController {
    
    public var device: Device?
    private var bleController: ConversationBLEController?
    private var messages: [Message] = []
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
//    private lazy var accessoryView: UIView = {
//        let v = IntrinsicLineDialogInputView()
//        v.backgroundColor = .lightGray
//        v.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
//        return v
//    }()
    
    private lazy var accessoryView: UIView = {
        let v = SimpleDialogInputView()
//        let v = IntrinsicLineDialogInputView()
        v.backgroundColor = .lightGray
        v.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        return v
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = accessoryView.frame.height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.backgroundColor = .blue
        return cell!
    }
}


extension ConversationViewController: UITextViewDelegate {
    
}

extension ConversationViewController: LineDialogInputViewDelegate {
    func lineDialogPresentPhotoLibrary() {
        
    }
    
    func lineDialogSendMessage(_ message: String) {
        
    }
    
    func lineDialogStickerSelected(_ sticker: Sticker) {
        
    }
    
    func lineDialogPresentCamera() {
        
    }
}


class ConversationViewControllerWithInputView: UITableViewController {
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private lazy var accessoryView: UIView = {
        let v = IntrinsicLineDialogInputView()
        v.backgroundColor = .lightGray
        v.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        return v
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = accessoryView.frame.height
    }
    
    public var device: Device?
    private var bleController: ConversationBLEController?
    private var messages: [Message] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.backgroundColor = .blue
        return cell!
    }
}
