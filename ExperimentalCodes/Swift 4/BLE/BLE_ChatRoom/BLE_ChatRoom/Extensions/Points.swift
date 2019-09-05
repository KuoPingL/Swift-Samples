//
//  Points.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func isInside(view: UIView) -> Bool {
        let location = self
        if location.x < view.frame.minX || location.y < view.frame.minY || location.x > view.frame.maxX || location.y > view.frame.maxY {
            return false
        }
        return true
    }
    
    func distanceFrom(point: CGPoint = .zero) -> CGFloat {
        let x = self.x - point.x
        let y = self.y - point.y
        return CGFloat(sqrtf(Float(x * x + y * y)))
    }
}
