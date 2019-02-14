//
//  Data + RNCryptor.swift
//  HelloWenSecureApp
//
//  Created by Jimmy on 2018/8/17.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
import RNCryptor        // 加碼或解碼

extension Data {
    
    /// Class func 解密
    ///
    /// - Parameters:
    ///   - url: url
    ///   - key: 鑰匙
    /// - Returns: Data?
    static func decrypt(from url: URL, key: String) -> Data? {
        do {
            let data = try Data(contentsOf: url)
            return data.decrypt(key: key)
        } catch {
            print("Fail to load file : \(url)")
            return nil
        }
    }
    
    /// 解密 Data
    ///
    /// - Parameter key: 鑰匙
    /// - Returns: Data?
    func decrypt(key: String) -> Data? {
//        guard let decryptedData = try? RNCryptor.decrypt(data: self, withPassword: key) else {
//            assertionFailure("Fail to decrypt")
//            return nil
//        }
//        return decryptedData
        
        do {
            let decryptedData = try RNCryptor.decrypt(data: self, withPassword: key)
            return decryptedData
        } catch {
            assertionFailure("Failed to decrypt")
            return nil
        }
    }
    
    
    /// 解密 Base64 Data (這次網路傳回來的資料是 Base64 加密的)
    ///
    /// - Parameter key: 鑰匙
    /// - Returns: Data?
    func decryptBase64(key: String) -> Data? {
        guard let encryptedData = Data(base64Encoded: self) else { return nil }
        
        return encryptedData.decrypt(key: key)
    }
    
    
    /// 解密 Data -> String?
    ///
    /// - Parameter key: 鑰匙
    /// - Returns: String?
    func decryptToString(key: String) -> String? {
        guard let decryptData = decryptBase64(key: key) else { return nil }
        guard let string = String(data: decryptData, encoding: .utf8) else {
            print("Failed to convert to String")
            return nil
        }
        return string
    }
    
    
    /// 加密 Data -> Data (一定可以加密)
    ///
    /// - Parameter key: 鑰匙
    /// - Returns: Data
    func encrypt(key: String) -> Data {
        let encryptedData = RNCryptor.encrypt(data: self, withPassword: key)
        return encryptedData
    }
    
    
    /// 加密並寫入檔案 (file://.... ) <- URL
    ///
    /// - Parameters:
    ///   - url: 檔案位置
    ///   - key: 鑰匙
    /// - Throws: func write(to url: URL, options: Data.WritingOptions = default) throws
    func encrypt(to url: URL, key: String) throws {
        let encryptedData = self.encrypt(key: key)
        try encryptedData.write(to: url)
    }
    
    
}
