//
//  ChatRoom.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ChatRoom: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    
    lazy var users: [UserModel] = {
        return UserModel.sample()
    }()
}
