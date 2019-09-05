//
//  AutoLayout.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    enum Constraints {
        case top, right, left, bottom, center
    }
    
    @objc @discardableResult func top(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat) -> UIView {
        checkTranslatesautoResizingMaskIntoConstraints()
        self.topAnchor.constraint(equalTo: equalTo, constant: constant)
    }
    
    @objc @discardableResult func bottom(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat) -> UIView {
        checkTranslatesautoResizingMaskIntoConstraints()
        self.bottomAnchor.constraint(equalTo: equalTo, constant: constant)
    }
    
    @objc @discardableResult func left(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat) -> UIView {
        checkTranslatesautoResizingMaskIntoConstraints()
        self.leftAnchor.constraint(equalTo: equalTo, constant: constant)
    }
    
    @objc @discardableResult func right(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat) -> UIView {
        checkTranslatesautoResizingMaskIntoConstraints()
        self.rightAnchor.constraint(equalTo: equalTo, constant: constant)
    }
    
//    @objc @discardableResult func centered(right)
    
    @objc func checkTranslatesautoResizingMaskIntoConstraints() {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints.toggle()
        }
    }
}
