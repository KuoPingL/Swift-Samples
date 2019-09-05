//
//  ConversationTextViewDelegate.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/18.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ConversationTextViewDelegate: NSObject, UITextViewDelegate {
    
    private var textView: UITextView?
    
    init(textView: UITextView) {
        super.init()
        self.textView = textView
        textView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            
        }
    }
    
}
