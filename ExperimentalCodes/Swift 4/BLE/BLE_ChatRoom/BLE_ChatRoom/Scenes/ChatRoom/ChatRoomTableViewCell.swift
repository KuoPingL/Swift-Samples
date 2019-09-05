//
//  ChatRoomTableViewCell.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ChatRoomTableViewCell: UITableViewCell, ChatRoomCellDelegate {
    static let cellID = "chatRoomTableViewCell"
    public var bleData: String = "" {
        didSet {
            user.bleData = bleData
            imageView?.image = user.avatar
            textLabel?.text = user.name
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            detailTextLabel?.text = "Last Seen : \(formatter.string(from: date))"
        }
    }
    
    private var user = UserModel.defaultUser()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        textLabel?.text = nil
        detailTextLabel?.text = nil
        user = UserModel.defaultUser()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implement")
    }
}
