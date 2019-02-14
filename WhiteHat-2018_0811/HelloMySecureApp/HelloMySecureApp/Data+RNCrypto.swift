//
//  Data+RNCrypto.swift
//  HelloMySecureApp
//
//  Created by Jimmy on 2018/8/11.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
import RNCryptor

extension Data {
    
    // Encrypt/Decrypt data for file.
    func decrypt(key: String) -> Data? {
        guard let decryptedData = try? RNCryptor.decrypt(data: self, withPassword: key) else {
            assertionFailure("Fail to decrypt")
            return nil
        }
        
        return decryptedData
    }
    
    static func decrypt(from: URL, key: String) -> Data? {
        guard let data = try? Data(contentsOf: from) else {
            print("Fail to load file : \(from)")
            return nil
        }
        
        return data.decrypt(key: key)
    }
    
    func encrypt(key: String) -> Data {
        let encryptedData = RNCryptor.encrypt(data: self, withPassword: key)
        return encryptedData
    }
    
    func encrypt(to: URL, key: String) throws {
        let encryptedData = encrypt(key: key)
        try encryptedData.write(to: to)
    }
    
    func decryptBase64(key: String) -> Data? {
        
        // Since the data from the site was in Base 64
        // TODO: Convert Back from Base 64
//        guard let string = String(data: self, encoding: .utf8) else {
//            print("Fail to convert Data to String")
//            return nil
//        }
        
        guard let encryptedData = Data(base64Encoded: self) else {
            return nil
        }
        
        guard let decryptedData = try? RNCryptor.decrypt(data: encryptedData, withPassword: key) else {
            assertionFailure("Fail to decrypt")
            return nil
        }
        
        return decryptedData
    }
    
    func decryptToString(key: String) -> String? {
        guard let data = decryptBase64(key: key) else {
            return nil
        }
        
        guard let string = String(data: data, encoding: .utf8) else {
            print("Fail to convert data to string")
            return nil
        }
        
        return string
    }
}
