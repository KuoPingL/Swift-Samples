//
//  Message.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/5.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

struct Message {
    
    enum MessageType {
        case text
        case image
        case video
        case gif
    }
    
    var text : String = ""
    var isSent : Bool
    var image: UIImage?
    
    init(text: String, isSent: Bool) {
        self.text = text
        self.isSent = isSent
    }
    
    init(image: UIImage?, isSent: Bool) {
        self.image = image
        self.isSent = isSent
    }
}
