//
//  ColorExtension.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init (red: IntegerLiteralType, green: IntegerLiteralType, blue: IntegerLiteralType, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
    static let LINE_BUTTON_STROKE_COLOR
        = UIColor(red: 116, green: 125, blue: 143, alpha: 1.0)
    
    static let LINE_SHOW_MORE_BUTTON_BACKGROUND_COLOR
        = UIColor(red: 54, green: 62, blue: 83, alpha: 1.0)
    static let LINE_STICKER_BUTTON_SELECTED_COLOR
        = UIColor(red: 59, green: 207, blue: 31, alpha: 1.0)
}
