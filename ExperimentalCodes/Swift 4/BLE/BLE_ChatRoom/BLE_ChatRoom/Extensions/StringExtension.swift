//
//  StringExtension.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/5.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
        }
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var cgFloatValue: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
}
