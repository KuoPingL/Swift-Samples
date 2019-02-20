//
//  ADDebug.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/29.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

class ADDebug {
    class func printer<T>(_ message: T) {
        #if DEBUG
        print("=================\nDEBUG :\n\(message)\n================")
        #endif
    }
}
