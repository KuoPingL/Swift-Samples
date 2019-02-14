//
//  String + RNCryptor.swift
//  HelloWenSecureApp
//
//  Created by Jimmy on 2018/8/17.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
import RNCryptor        // 加碼或解碼

extension String {
    
    
    /// 解密 Base64 字串
    ///
    /// - Parameter key: 鑰匙
    /// - Returns: String?
    func decryptBase64(key: String) -> String? {
        guard let encryptedData = Data(base64Encoded: self) else
        { return nil }
        
        // 解密 Data -> String
        do {
            let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: key)
            // 轉成 String
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    
    /// 加密 並回傳加密後的字串
    ///
    /// - Parameter key: 鑰匙
    /// - Returns: String?
    func encryptToBase64(key: String) -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        let encryptedData = data.encrypt(key: key)
        return encryptedData.base64EncodedString()
    }
}
