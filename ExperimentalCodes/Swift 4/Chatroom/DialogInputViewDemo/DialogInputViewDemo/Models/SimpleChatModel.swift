//
//  ChatModel.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

struct SimpleChatModel {
    var message: String
    var image: UIImage?
    var isSent: Bool
    var sender: UserModel
    var isSender: Bool
}
