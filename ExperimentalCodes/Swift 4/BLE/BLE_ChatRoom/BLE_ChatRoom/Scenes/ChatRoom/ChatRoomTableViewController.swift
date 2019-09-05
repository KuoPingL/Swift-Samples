//
//  ChatRoomTableViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/10.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ChatRoomTableViewController: UITableViewController {
    public var delegate: ChatRoomListControllerDelegate?
    
    private var devices: [Device] = [] {
        didSet {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        tableView.register(ChatRoomTableViewCell.self, forCellReuseIdentifier: ChatRoomTableViewCell.cellID)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.cellID, for: indexPath) as? ChatRoomTableViewCell
        
        if cell == nil {
            cell = ChatRoomTableViewCell(style: .subtitle, reuseIdentifier: ChatRoomTableViewCell.cellID)
        }
        
        cell?.bleData = devices[indexPath.row].name
        
        cell?.layer.cornerRadius = 10.0
        cell?.layer.masksToBounds = true
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(devices[indexPath.row])
    }
    
    @objc func refresh() {
        delegate?.refreshBLE()
    }
    
}

extension ChatRoomTableViewController: ChatRoomListDelegate {
    func reloadData(_ devices: [Device]) {
        self.devices = devices
    }
}
