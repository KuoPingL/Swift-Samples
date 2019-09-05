//
//  ViewControllerExtension.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func addObserveKeyboardWillShow(with selector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillShowNotification, object: object)
    }
    
    public func removeObserveKeyboardWillShow(object: Any?) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: object)
    }
    
    public func addObserveKeyboardWillHide(with selector: Selector, object: Any?) {
        NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillHideNotification, object: object)
    }
    
    public func removeObserveKeyboardWillHide(object: Any?) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: object)
    }
}
