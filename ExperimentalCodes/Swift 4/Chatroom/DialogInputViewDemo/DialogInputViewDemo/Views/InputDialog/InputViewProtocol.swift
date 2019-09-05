//
//  InputViewProtocol.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
protocol SimpleInputViewDelegate: AnyObject {
    func send(message: String)
    func textViewDidBeginEditing()
    func textViewDidEndEditing()
    func textViewDidChange()
}

extension SimpleInputViewDelegate {
    func textViewDidBeginEditing() {
        
    }

    func textViewDidEndEditing() {
        
    }
    
    func textViewDidChange() {
        
    }
}
