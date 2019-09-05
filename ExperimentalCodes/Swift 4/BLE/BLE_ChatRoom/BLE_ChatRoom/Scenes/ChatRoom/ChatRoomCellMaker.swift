//
//  ChatRoomCellMaker.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol ChatRoomCellDelegate {
    var bleData: String {get set}
}

class ChatRoomCellMaker {
    static func createCellFor<T: UIViewController> (_ controller: T) -> ChatRoomCellDelegate? {
        if controller is UITableViewController {
            return ChatRoomTableViewCell(style: .subtitle, reuseIdentifier: ChatRoomTableViewCell.cellID)
        } else if controller is UICollectionViewController {
            return ChatRoomCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        } else {
            print("Controller should only be TableViewController or CollectionViewController")
            return nil
        }
    }
}
