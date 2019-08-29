//
//  ChatCell.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatCell: UITableViewCell {
    static let cellID = "CHAT_CELL"
    var chat: SimpeChatModel? {
        didSet {
            guard let chat = chat else {
                return
            }
            
            if chat.message.isEmpty {
                
            } else {
                textLabel?.text = chat.message
            }
        }
    }
    
}
