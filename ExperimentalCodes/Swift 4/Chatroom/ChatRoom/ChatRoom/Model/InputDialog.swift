//
//  ChatRoom.swift
//  ChatRoom
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
struct InputDialog {
    var name: String
    var thumbnailImage: UIImage?
    var inputContainer: UIView
    
    init(name: String, inputContainer: UIView) {
        self.name = name
        self.thumbnailImage = nil
        self.inputContainer = inputContainer
    }
}
