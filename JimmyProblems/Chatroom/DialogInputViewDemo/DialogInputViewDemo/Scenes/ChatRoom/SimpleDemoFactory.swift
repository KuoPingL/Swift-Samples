//
//  SimpleDemoFactory.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/9/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleDemoFactory {
    class func demo(_ simpleDemo: SimpleDemos) -> UIViewController {
        switch simpleDemo {
        case .addTextViewAsSubView:
            return UIViewController()
        case .useTextFieldAsInputView:
            return UIViewController()
        case .useTextViewAsFooter:
            return UIViewController()
        case .useTextViewAsInputView:
            return UIViewController()
        }
    }
}
