//
//  KeyManager.swift
//  HelloWenSecureApp
//
//  Created by Jimmy on 2018/8/17.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
class KeyManager: NSObject {
    static let shared = KeyManager()
    fileprivate override init() {
        super.init()
    }
    
    // Primary Key 可以存放成 var 但絕對不要用 let。尤其是 static let。
    // 因為可以在記憶體中找到。
    // 更好的解決方法就是用 func 在需要時才回傳。
    // 並用不同的方法來取得，像是將 "123456" 解開成一個程式來回傳。
    func primaryKey() -> String {
        // primary Key = 123456
        return "12" + String(30 + 4) + String(7 * 8)
    }
}
