//
//  String + RNCrypto.swift
//  HelloMySecureApp
//
//  Created by Jimmy on 2018/8/11.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
import RNCryptor

extension String {
    func decryptBase64(key: String) -> String? {
        // Convert self (String) to data
        guard let encryptedData = Data(base64Encoded: self) else {
            return nil
        }
        
        // Decrypt data with Password
        // Convert decrypted Data to String
        guard let decryptedData = try? RNCryptor.decrypt(data: encryptedData, withPassword: key),
            let string = String(data: decryptedData, encoding: .utf8) else {
            assertionFailure("Fail to decrypt data or convert to string")
            return nil
        }
        
        return string
    }
    
    func encryptToBase64(key: String) -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let encryptedData = RNCryptor.encrypt(data: data, withPassword: key)
        
        return encryptedData.base64EncodedString()
    }
}
