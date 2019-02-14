//
//  ViewController.swift
//  HelloMySecureApp
//
//  Created by Jimmy on 2018/8/11.
//  Copyright © 2018年 Demo. All rights reserved.
//

import UIKit
import TrustKit
import KeychainAccess
import LocalAuthentication

class KeyManager: NSObject {
    static let shared = KeyManager()
    fileprivate override init() {
        super.init()
    }
    
    func primaryKey() -> String {
        return "12" + String(30 + 4) + String(7 * 8)
    }
}

// SSL Pinning ==> Base64(SHA256(Public key))
// We can use Trust Key (third party) to check if the Public Key is valid.
// https://www.ssllabs.com/ssltest/

class ViewController: UIViewController {

    // Do not use let, because the result will be stored in memory
    // It is even better to use a singleton to get the primary key
    var primaryKey = KeyManager.shared.primaryKey()
    @IBOutlet weak var inputTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let trustKitConfig: [String: Any] = [
            kTSKPinnedDomains: [
                "google.com":[
                    // Basic Variables
                    kTSKEnforcePinning: true, // 是否要強制進行Pinning檢查，建議先設成 false，用預設方法處理。除非真的要嚴謹處理，完全排除。
                    kTSKIncludeSubdomains: true,
                    kTSKPublicKeyAlgorithms: [kTSKAlgorithmRsa2048],
                    kTSKPublicKeyHashes: [
                        "6eIe4hLWdLB6xKi1taheaZdVs4nfzsfQ5Ui1wUe3G9w=",
                        "f8NnEFZxQ4ExFOhSN7EiFWtiudZQVD2oY60uauV/n78="] // Pinning Key
                ],
//                "yahoo.com":[]
            ]
        ]
        
        // Note! you can execute it once only
        TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
        
        // Demo for Data Protection.
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            assertionFailure("Fail to get Documents URL")
            return
        }
        
        // Create a file to be protected
        let content = ["username":"Banana"]
        let fileURL = documentsURL.appendingPathComponent("Protected.plist")
        
        (content as NSDictionary).write(to: fileURL, atomically: true)
        
        // Create a file that will not be protected
        let fileURL2 = documentsURL.appendingPathComponent("Unprotected.plist")
        (content as NSDictionary).write(to: fileURL2, atomically: true)
        
        // Set the file as no protection.
        let attributes = [FileAttributeKey.protectionKey: FileProtectionType.none]
        do {
            try FileManager.default.setAttributes(attributes, ofItemAtPath: fileURL2.path)
        } catch {
            print("Set attribute fail: \(error)")
        }
        
        // LocalAuthenication Demo
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            print("OK. User already setup the biometric.")
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "....") { (granted, error) in
                
            }
        } else {
            print("no biometric")
        }
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            print("OK. User already setup the passcode")
        } else {
            print("NG. User does not setup the passcode")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func apiTestBtnPressed(_ sender: Any) {
        // Get JSON
        //MARK:- AES 演算法
        // RNCryptor
//        let urlString = "http://class.softarts.cc/AppSecurity/encryptData.json"
        let urlString               = "AwHGz7Dg8CRQFXD5E3AYACYSXLm/YSaGLyEmjB90cjgIojfLqY3fyzvshFT7Z+maM5TnHX0do3wUDiFA4SLxK+3ovdFxewpDyWT63TfIE1G0Tho9RhlzD3uU+7BaI0S8SRoBU6twhEqWsMAnmfFvA6NmYrsPLRgWiTg0dvxSaJqpZg==".decryptBase64(key: primaryKey)!
//        let packageKey              = "zaq1xsw2cde3vfr4"
        let packageKey = "AwHTod7ML4II4zNvzP+++LQIez6UYS93y1vKzJItJM86qXf4MMhR82ih3xAGJm9pe1/82QBIJ7o8VKtfc4XKA0CLUAGS60deehoJOjAQz6nbjb9yH/ClDs0ZrPNzUobbRug=".decryptBase64(key: primaryKey)!
        // 就算不夠 16 or 32 字，RNCryptor 也會幫你補滿
//        let encryptionKey_Prefix    = "1qaz2wsx"
        let encryptionKey_Prefix = "AwFLZ1/Rx1Bx7gZiXPrDTqEMPqk8JDC3dr//e75Bk3EA1SgRLOgmfSF4F6gx7e0k7B0f0WMczCgHgswhbllTxk+J+VuOSsnEt4Lk6Ld5mIX6uw==".decryptBase64(key: primaryKey)!
        
//        let encryptedURL = urlString.encryptToBase64(key: primaryKey)
//        let encryptedPackageKey = packageKey.encryptToBase64(key: primaryKey)
//        let encryptedPrefix = encryptionKey_Prefix.encryptToBase64(key: primaryKey)
//
//
//        print("urlString ==> \(encryptedURL!)")
//        print("packageKey ==> \(encryptedPackageKey!)")
//        print("prefix ==> \(encryptedPrefix!)")
        
        
        
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
//                if let error = error {
//                    self?.display(message: error.localizedDescription)
//                    return
//                }
//
//                if let data = data, let secretKey = String(data: data, encoding: .utf8) {
//                    print(secretKey)
//                }
//            }.resume()
//        }
        
        
        
        guard let url = URL(string: urlString) else {
            assertionFailure("Unable to convert \(urlString) to url")
            return
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) {[weak self] (data, response, error) in
            if let error = error {
                self?.display(message: error.localizedDescription)
                return
            }

            guard let data = data else {
                return
            }
            
            guard let encryptedContent = String(data: data, encoding: .utf8) else {
                assertionFailure("Fail to convert data to string")
                return
            }
            
            print("encryptedContent: \(encryptedContent)")
            
            // 解開最外包
//            guard let json = data.decryptToString(key: packageKey) else {
//                return
//            }
//            print(json)
//            do {
//                let myJSON = try JSONDecoder().decode(SamplePackage.self, from: json.data(using: .utf8)!)
//                print(myJSON)
//                print(myJSON.pw)
//            } catch let error {
//                print(error.localizedDescription)
//            }
            
            let decoder = JSONDecoder()
            guard let decryptedData = data.decryptBase64(key: packageKey), let package = try? decoder.decode(SamplePackage.self, from: decryptedData) else {
                assertionFailure("Fail to decode as package struct.")
                return
            }
            print("pw: \(package.pw)")
            
            let finalPasswordKey = encryptionKey_Prefix + package.timestamp
            print(finalPasswordKey)
            
            guard let finalPassword = package.pw.decryptBase64(key: finalPasswordKey) else {
                print("Fail to decrypt pw.")
                return
            }
            
            print("Final Password : \(finalPassword)")
            
        }
        
        task.resume()
        
    }
    
    @IBAction func sslPinningBtnPressed(_ sender: Any) {
        guard let url = URL(string: "https://google.com") else {
            assertionFailure("Invalid URL.")
            return
        }
        let config = URLSessionConfiguration.default
        // Need to set delegate
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let dataTask = session.dataTask(with: url) {[weak self] (data, response, error) in
            //...
            if let error = error {
                self?.display(message: error.localizedDescription)
                return
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            
            print("OK, receive \(data.count) bytes.")
        }
        
        dataTask.resume()
    }
    
    
    fileprivate func display(message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let action_OK = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(action_OK)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveToKeychainBtnPressed(_ sender: Any) {
        let token = "1qaz3wsx"
        let encryptedToken = token.encryptToBase64(key: primaryKey)
        let keychain = Keychain(service: "accessServer")
        keychain["encryptedToken"] = encryptedToken
        // Cannot assign value of type 'Data' to type 'String?'
        // keychain["secretData"] = Data([0x01, 0x02, 0x03])
        keychain[data: "secretData"] = Data([0x01, 0x02, 0x03])
    }
    
    @IBAction func loadFromKeychainBtnPressed(_ sender: Any) {
        let keychain = Keychain(service: "accessServer")
        guard let encryptedToken = keychain["encryptedToken"],
            let token = encryptedToken.decryptBase64(key: primaryKey) else {
            print("Fail to get encryptedToken from Keychain.")
                return
        }
        
        guard let secretData = keychain["secretData"] else {
            print("Fail to get secretData from Keychain.")
            return
        }
        
        print("Scret Data : \(secretData)") // ""
        
        guard let newSecretData = keychain[data: "secretData"] else {
            print("Fail to get newSecretData from Keychain.")
            return
        }
        
        print("Proper Scret Data : \(newSecretData)")
        
        print("Token : \(token)")
        
        print(keychain.allKeys())
        // Clear value only
        keychain["secretData"] = nil // Key is still there
        
        if let removedData = keychain[data: "secretData"] {
            print("Secret Data after Removed : \(removedData)")
        } else {
            print("Secret Data is nil")
            print(keychain.allKeys())
        }
        
        // Remove the whole key-value entry.
        try? keychain.remove("secretData")
        print(keychain.allKeys())
        
    }
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBAction func encryptFileBtnPressed(_ sender: Any) {
        NSLog("Start !!")
        // Get URL of image file from bundle
        guard let sourceURL = Bundle.main.url(forResource: "flower.jpg", withExtension: nil) else {
            assertionFailure("Fail to get image")
            return
        }
        
        guard let imageData = try? Data(contentsOf: sourceURL) else {
            assertionFailure("Fail to get imageData from file.")
            return
        }
        
        // Encrypt and save the file content.
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.x")
        try? imageData.encrypt(to: outputURL, key: primaryKey)
        NSLog("Finished !!")
        print("Output.x : \(outputURL)")
        resultImageView.image = nil
        // payload > ipa > 封存工具來解
        // otool -ov {execution file}
    }
    
    @IBAction func decryptFileBtnPressed(_ sender: Any) {
        NSLog("Start !!")
        let inputURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.x")
        
        guard let decryptedData = Data.decrypt(from: inputURL, key: primaryKey) else {
            print("Fail to Decrypt")
            return
        }
        
        resultImageView.contentMode = .scaleAspectFill
        NSLog("FINISHED !!")
        resultImageView.image = UIImage(data: decryptedData)
    }
    @IBAction func submitBtnPressed(_ sender: Any) {
        guard let input = inputTextfield.text, !input.isEmpty else {
            // Show error to user
            return
        }
        let pattern = "^[a-zA-Z0-9]{6,12}$"
        
        let result = input.range(of: pattern, options: .regularExpression)
        let message = (result == nil ? "Invalid" : "OK")
        print("[\(input)] ==> \(message).")
    }
}

extension ViewController: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print(challenge)
        
        let validator = TrustKit.sharedInstance().pinningValidator
        if validator.handle(challenge, completionHandler: completionHandler) == false {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

extension ViewController {
    // Injection
    // To get a single user
    // select * from users where login='$username' and password='$password'
    //
    //
    // $ username = ' or 1= 1 /*
    // select * from users where login ='' or 1=1 /*' and pasword = '$password'
    
    
}

struct SamplePackage: Codable & Decodable {
    let username: String
    let pw: String
    let timestamp: String
}

