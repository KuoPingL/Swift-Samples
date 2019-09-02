//
//  ChatRoomLogDelegate.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatRoomLogDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var messages:[SimpleChatModel] = []
    private weak var tableView: UITableView?
    private weak var delegate: UIViewController?
    
    init(tableView: UITableView, delegate: UIViewController) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SimpleChatCell.self, forCellReuseIdentifier: SimpleChatCell.cellID)
        
        self.delegate = delegate
    }
    
    public func appendMessage(_ message: SimpleChatModel) {
        
        tableView?.beginUpdates()
        messages.append(message)
        tableView?.insertRows(at: [IndexPath(row: messages.count - 1, section: 0)], with: message.isSender ? .right : .left)
        tableView?.endUpdates()
        
        DispatchQueue.main.async {
            self.tableView?.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SimpleChatCell.cellID) as? SimpleChatCell
        if cell == nil {
            cell = SimpleChatCell(style: .default, reuseIdentifier: SimpleChatCell.cellID)
        }
        
        cell?.chat = messages[indexPath.row]
        
        return cell!
    }
}
