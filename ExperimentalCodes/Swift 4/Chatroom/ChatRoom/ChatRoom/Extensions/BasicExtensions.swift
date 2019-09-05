
//
//  BasicExtensions.swift
//  ChatRoom
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation

protocol Declarative {
    init()
}

extension NSObject: Declarative { }

extension Declarative where Self: NSObject {
    init(_ configureHandler: (Self) -> Void) {
        self.init()
        configureHandler(self)
    }
}
