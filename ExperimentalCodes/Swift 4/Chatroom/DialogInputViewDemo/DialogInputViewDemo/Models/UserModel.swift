//
//  UserModel.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

struct UserModel {
    var name: String
    var id: String
    var avatar: UIImage?
    
    static func sample() -> [UserModel] {
        return
            [UserModel(name: "John", id: "12345", avatar: nil),
             UserModel(name: "Mary", id: "23456", avatar: nil)]
    }
}
