//
//  UIImageExtension.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static var avatar_A: UIImage? {
        get {
           return UIImage(named: "Avatar_A", in: nil, compatibleWith: nil)
        }
    }
    
    static var avatar_B: UIImage? {
        get {
            return UIImage(named: "Avatar_B", in: nil, compatibleWith: nil)
        }
    }
    
    static var bubbleReceived: UIImage? {
        get {
            return UIImage(named: "Bubble_Received", in: nil, compatibleWith: nil)
        }
    }
    
    static var bubbleSend: UIImage? {
        get {
            return UIImage(named: "Bubble_Sent", in: nil, compatibleWith: nil)
        }
    }
    
    static var send: UIImage? {
        get {
            return UIImage(named: "Send", in: nil, compatibleWith: nil)
        }
    }
    
    static var microphone: UIImage? {
        get {
            return UIImage(named: "Microphone", in: nil, compatibleWith: nil)
        }
    }
}
