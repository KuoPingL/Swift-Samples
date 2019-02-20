//
//  UIColor + Extension.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/29.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (_ r: Int, _ g: Int, _ b: Int, a: CGFloat) {
        ADDebug.printer("RED : \(CGFloat(r)/255.0)\nGREEN : \(CGFloat(g)/255.0)\nBLUE : \(CGFloat(b)/255.0)")
        
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
}
