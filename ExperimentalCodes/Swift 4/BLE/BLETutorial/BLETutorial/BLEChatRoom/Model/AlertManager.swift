//
//  AlertManager.swift
//  BLETutorial
//
//  Created by Jimmy on 2019/7/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

struct AlertManager {
    enum AlertButtons {
        case ok
        case ok_cancel
        case ok_cancel_warning
    }
    enum Alerts {
        case message(title: String, message: String, buttonType: AlertButtons)
        case warning(title: String, message: String, buttonType: AlertButtons)
    }
    
    static func alert(_ alert: Alerts, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        
        switch alert {
        case .message(let title, let message, let buttonType):
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actions = AlertManager.alertButton(buttonType, okHandler: okHandler, cancelHandler: cancelHandler)
            for action in actions {
                alertController.addAction(action)
            }
            
            return alertController
            
        case .warning(let title, let message, let buttonType):
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actions = AlertManager.alertButton(buttonType, okHandler: okHandler, cancelHandler: cancelHandler)
            for action in actions {
                alertController.addAction(action)
            }
            return alertController
        }
    }
    
    fileprivate static func alertButton(_ type: AlertButtons, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) -> [UIAlertAction] {
        switch type {
        case .ok:
            return [UIAlertAction(title: "OK", style: .default, handler: okHandler)]
        case .ok_cancel:
            let ok = UIAlertAction(title: "OK", style: .default, handler: okHandler)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            return [ok, cancel]
        case .ok_cancel_warning:
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: okHandler)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            return [ok, cancel]
        }
    }
}
