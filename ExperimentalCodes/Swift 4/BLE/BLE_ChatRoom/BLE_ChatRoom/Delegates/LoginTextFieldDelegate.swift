//
//  LoginTextFieldDelegate.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class LoginTextFieldDelegate: NSObject, UITextFieldDelegate {
    private var textField: UITextField
    
    init(textField: UITextField) {
        self.textField = textField
        super.init()
        prepareTextField()
    }
    
    private func prepareTextField() {
        textField.delegate = self
        textField.keyboardType = .alphabet
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
