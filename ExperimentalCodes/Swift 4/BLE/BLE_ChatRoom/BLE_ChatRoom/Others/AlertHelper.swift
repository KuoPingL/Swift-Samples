//
//  AlertHelper.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    @discardableResult class func warn(delegate: UIViewController?, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: "_alert_title".localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "_alert_ok".localized, style: .default, handler: nil))
        delegate?.present(alert, animated: true, completion: nil)
        return alert
    }
    
}
