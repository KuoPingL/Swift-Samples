//
//  ViewController.swift
//  HelloWenSecureApp
//
//  Created by Jimmy on 2018/8/14.
//  Copyright © 2018年 Demo. All rights reserved.
//

import UIKit
import KeychainAccess       // 使用 Keychain 來儲存資料
// import RNCryptor         // 加碼或解碼
import TrustKit             // 檢查 SSL 是否正確 (避免被中途劫走 ie WiFi)
import LocalAuthentication  // 檢查使用者的加密是否合適 app 的使用 (faceID, finger ...)

class ViewController: UIViewController {

    // 雖然 RNCryptor 用 32 bytes 的字串來做 Key
    // 但就算不夠，RNCryptor 也會幫你補滿
    var primaryKey      = KeyManager.shared.primaryKey()
    let keyChainService = "accessService"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputTextField.placeholder = "^[a-zA-Z0-9]{6,12}$"
        setupTrustKit()
        runDataProtection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- BUTTON ACTIONs
    @IBAction func API_TESTING_BTN_PRESSED(_ sender: Any) {
        
        // 原本的值
        let urlString               = "http://class.softarts.cc/AppSecurity/encryptData.json"
        let packageKey              = "zaq1xsw2cde3vfr4"
        let encryptionKey_Prefix    = "1qaz2wsx"
        
        // 加密後的值
        var encryptedURLString:             String?
        var encryptedPackageKey:            String?
        var encryptedEncryptedKey_Prefix:   String?
        
        //FIXME: Uncomment this to run the simple API_TEST
        // 簡單的 API Test
        // (使用未加密的 urlString, packageKey, encryptedKey_Prefix)
//        API_TESTING(urlString: urlString, packageKey: packageKey, encryptionKey_Prefix: encryptionKey_Prefix)
        
        // 將 urlString, packageKey 與 encryptionKey_Prefix 加密
        // 並設在新的 new_urlString, new_packageKey, new_encryptedKey_Prefix
        
        encryptedURLString = urlString.encryptToBase64(key: primaryKey)
        encryptedPackageKey = packageKey.encryptToBase64(key: primaryKey)
        encryptedEncryptedKey_Prefix = encryptionKey_Prefix.encryptToBase64(key: primaryKey)
        
        // 之後就可以不用加密前的資料 urlString, packageKey, encryptedKey_Prefix
        // 這樣的話你的 APP 就會多了保障，不用擔心有人 Hack 了
        // 因為要解密需要知道的有兩個東西 ：
        // 1. Primary Key (由 func 製造，所以無法在記憶體被讀取)
        // 2. 解碼的邏輯 (AES 128 (standard)/256/512, DES, 3DES ...)
        // https://www.apple.com/business/docs/iOS_Security_Guide.pdf
        let new_urlString = "AwGPHizG37RQL7w8bZrrF0HjNztzyWn7i5Rwu7+jzqW4gGDK9jZezlXNbSKe3hr9RwjqrJIpl+GN+tbZZA8ppnFPWMltHbszh9GsGX3Evx078xxxv2hxo1AqYeK5bm8jVSfRAFDJyRxDbyy9C2YqTm6uZOZduqlBz6FtzTFD3uxV7g==".decryptBase64(key: primaryKey)!
        let new_packageKey = "AwFIxY+hs4AepGaEyRmkpzLI4VIOBbdhRWVIYAzDcKFBYFISodXJ94Z4eZevZUF6zhDHU/exZwlwIxcHJcC4BZ8pXHURYbM82SBvtQER6Vtj1dMoZXqcFxDgW2+3RjwViYE=".decryptBase64(key: primaryKey)!
        let new_encryptedKey_Prefix = "AwGvzOzY1mpnDXTzlTswjqJaeSO7wbsfDaCzA+271wcHHuN8D9wwaAdinfvMykIVMrGjZrpcYf0hNZQF42To1MagquE5v7eKsoTc+5wIvTbjoA==".decryptBase64(key: primaryKey)!
        API_TESTING(urlString: new_urlString, packageKey: new_packageKey, encryptionKey_Prefix: new_encryptedKey_Prefix)
    }
    
    @IBAction func SSL_PINNING_BTN_PRESSED(_ sender: Any) {
        connectToGoogle()
    }
    
    @IBAction func SAVE_to_KEYCHAIN(_ sender: Any) {
        saveToKeychain()
    }
    
    @IBAction func LOAD_from_KEYCHAIN(_ sender: Any) {
        loadFromKeychain()
    }
    
    @IBOutlet weak var encryptedImageView: UIImageView!
    @IBAction func ENCRYPT_FILE(_ sender: Any) {
        encryptImageFromBundle()
    }
    
    @IBAction func DECRYPT_FILE(_ sender: Any) {
        decryptImageFromOutputX()
    }
    
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBAction func SUBMIT_BTN_PRESSED(_ sender: Any) {
        print("===== SIMPLE REGULAR EXPRESSION ====")
        guard let input = inputTextField.text, !input.isEmpty else {
            // Show error to user
            return
        }
        let pattern = "^[a-zA-Z0-9]{6,12}$"
        
        let result = input.range(of: pattern, options: .regularExpression)
        let message = (result == nil ? "Invalid" : "OK")
        print("[\(input)] ==> \(message).")
    }
    
}

//MARK:- RNCryptor 使用方法
extension ViewController {
    
    fileprivate func API_TESTING(urlString: String, packageKey: String, encryptionKey_Prefix: String) {
        guard let url = URL(string: urlString) else {
            assertionFailure("Unable to convert \(urlString) to url")
            return
        }
        let urlConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: urlConfig)
        let task = session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                assertionFailure("data is nil")
                return
            }
            
            guard let encryptedContent = String(data: data, encoding: .utf8) else {
                assertionFailure("Fail to convert data to string")
                return
            }
            /* 回傳的值是 Base64
             AwEiP1ygP0ahAzumpcIiu3O4XkGZHUvF+hle2Yfc997fNtXtUwFmBkOFJydNq1gHJhWrKKRATVS2BniojhXbb7KoSXtOR7WCVhW7FukuVF5ACvxlb6GV7nzUY3EkktrDrgDYxsm9yv1MXv9Wwvsc11ubM5DNcJS7uUqruhSZC2FSzGhUVk37bsKub4bXiAZ6bPL9HYcezzYnT4sICg3KZ/MMiSxHUkbD9EJ+uHhltRur2wSYX4zxWkKZTXWETUduwAzCCMBLBuMFHx17QeZE12Z+xocU+pB0YoUGrBUUGPMsZELsIliHsaCN8AOPGAuH0f4=
             */
            print("encryptedContent: \(encryptedContent)")
            
            // 先解開 Base64
            let decoder = JSONDecoder()
            guard let decryptedData = data.decryptBase64(key: packageKey) else {
                return
            }
            
            do {
                let package = try decoder.decode(SimplePackage.self, from: decryptedData)
                print("使用者名稱： \(package.username)")
                print("使用者密碼： \(package.pw)")
                print("時間： \(package.timestamp)")
                
                // 最終密碼鑰匙
                let finalPasswordKey = encryptionKey_Prefix + package.timestamp
                print("終極密碼鑰匙 : \(finalPasswordKey)")
                
                guard let finalPassword = package.pw.encryptToBase64(key: finalPasswordKey) else {
                    print("Fail to decrypt pw.")
                    return
                }
                
                print("終極密碼 : \(finalPassword)")
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    fileprivate func encryptImageFromBundle() {
        encryptedImageView.image = nil
        print("請用虛擬機跑，這樣你才可以找到 output.x，並用 hex fiend來看解密的值。")
        NSLog("------- 開始加密 -------")
        // Fetch IMAGE from BUNDLE
        guard let sourceURL = Bundle.main.url(forResource: "flower.jpg", withExtension: nil) else {
            print("無法取得 flower.jpg")
            return
        }
        
        guard let imageData = try? Data(contentsOf: sourceURL) else {
            print("無法讀取圖像 data")
            return
        }
        
        // 加密
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.x")
        try? imageData.encrypt(to: outputURL, key: primaryKey)
        NSLog("------- 加密結束 查看所花的時間 --------")
        print("很快吧 ~~~~ ")
    }
    
    fileprivate func decryptImageFromOutputX() {
        
        NSLog("---------- 解密開始 -----------")
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.x")
        
        guard let imageData = Data.decrypt(from: outputURL, key: primaryKey) else {
            print("Failed to Decrypt")
            return
        }
        
        encryptedImageView.contentMode = .scaleAspectFill
        encryptedImageView.image = UIImage(data: imageData)
        NSLog("--------- 解密完成 -----------")
        
    }
}

//MARK:- KEYCHAIN ACCESS 使用方法
// https://github.com/kishikawakatsumi/KeychainAccess
extension ViewController {
    fileprivate func saveToKeychain() {
        print("=========== SAVE TO KEYCHAIN ===========")
        let token = "1qaz3wsx"
        let encryptedToken = token.encryptToBase64(key: primaryKey)
        // 建立 Keychain 並定義 Service 是什麼
        let keychain = Keychain(service: keyChainService)
        // 將你要儲存的值放入 就像 Dictionary
        keychain["encryptedToken"] = encryptedToken
        
        // 但是上面的只是簡單的寫法
        // 如果要放 Data 就會出錯
        // Cannot assign value of type 'Data' to type 'String?'
        // keychain["secretData"] = Data([0x01, 0x02, 0x03])
        
        // 正確放的方法是 :
        // 要註明放入的是 data :
        keychain[data: "secretData"] = Data([0x01, 0x02, 0x03])
    }
    
    fileprivate func loadFromKeychain() {
        print("=========== LOAD FROM KEYCHAIN ===========")
        let keychain = Keychain(service: keyChainService)
        guard let encryptedToken = keychain["encryptedToken"], let token = encryptedToken.decryptBase64(key: primaryKey) else {
            print("Fail to get encryptedToken from Keychain.")
            return
        }
        
        print("TOKEN : \(token)")
        
        guard let secretData = keychain["secretData"] else {
            print("Fail to get secretData from Keychain.")
            return
        }
        
        print("錯誤取法的秘密字串 : \(secretData)")
        
        // 就如放入資料時，取資料也有正確的取法
        // 字串也可以 keychain[string: "encryptedToken"]
        guard let actualSecretData = keychain[data: "secretData"] else {
            print("Fail to get secretData from Keychain.")
            return
        }
        
        print("正確取法的秘密字串 : \(actualSecretData)")
        
        print("----- KEYCHAIN KEYS ------")
        print(keychain.allKeys())
        
        print("----- REMOVE VALUE from KEYCHAIN with KEY -----")
        try? keychain.remove("scretData")
        print(keychain.allKeys())
        
        print("----- SET SECRET DATA to nil -----")
        keychain["secretData"] = nil
        print(keychain.allKeys())
        
    }
}

//MARK:- TrustKit 使用方法
extension ViewController: URLSessionDelegate {
    fileprivate func setupTrustKit() {
        // https://github.com/datatheorem/TrustKit
        // 這次我們使用 Google.com 來測試
        // 首先，TrustKit 主要就是偵測網站的 SSL 是否正確，
        // 避免中途被不知名的 Server 劫走的問題。
        // 因為基本上，Apple 的作法就是只要 SSL 符合要求的就可以了，
        // 但不會要求是否正確，所以要用 TrustKit 來做檢測。
        
        // 首先要去 SSL Lab 來抓 Google.com 的 SSL
        // https://www.ssllabs.com/ssltest/
        // 輸入 google.com 並點選第一個 Server
        // 當中有數個 Certificate 我們要找的是 RSA 2048 bits
        // 這是目前標準的。
        // 在 subject 中，取得 Pin SHA256 的值。
        // 1. CFVZVGzBjorBhC0lONA9dyJwVxt+WdgGoMXbgXkNQAI=
        // 並在 Additional Certificate 中取得
        // 2. f8NnEFZxQ4ExFOhSN7EiFWtiudZQVD2oY60uauV/n78=
        
        let trustKitConfig: [String:Any] = [
            kTSKPinnedDomains: [
                "google.com": [
                    // BASIC SETTINGs
                    // 是否要強制進行Pinning檢查，建議先設成 false，用預設方法處理。除非真的要嚴謹處理，完全排除。
                    kTSKEnforcePinning: true,
                    kTSKIncludeSubdomains: true,
                    kTSKPublicKeyAlgorithms: [kTSKAlgorithmRsa2048],
                    kTSKPublicKeyHashes: [
                        // PINNING KEYs
                        // 請改變 PINNING KEYS 再看看結果
                        // 記住，假的 PINNING KEYS 跟真的都有相同的長度
                        "CFVZVGzBjorBhC0lONA9dyJwVxt+WdgGoMXbgXkNQAI=",
                        "f8NnEFZxQ4ExFOhSN7EiFWtiudZQVD2oY60uauV/n78="
                    ]
                ] //, 可以加更多的喔
            ]
        ]
        
        // 注意 ！ 這行只能呼叫一次
        TrustKit.initSharedInstance(withConfiguration: trustKitConfig)
    }
    
    fileprivate func connectToGoogle() {
        guard let url = URL(string: "https://google.com") else {
            assertionFailure("Invalid URL.")
            return
        }
        
        let config = URLSessionConfiguration.default
        // Need to set delegate
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            print("OK, receive \(data.count) bytes.")
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print(challenge)
        
        let validator = TrustKit.sharedInstance().pinningValidator
        if validator.handle(challenge, completionHandler: completionHandler) == false {
            // 當 SSL 與 TrustKit 中的不符，就用 Apple 原本的方法來 Handle。
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

//MARK:- DATA PROTECTION
extension ViewController {
    // 這部分需要實機，且要有付費 Account。
    // 要開啟 Data Protection 這功能
    // 想測試再給我你的 UIUD 我再給你 p12 及 mobileprovision 檔
    
    // 呼叫時，請注意 AppDelegate 顯示的資訊，AppDelegate 有 Code 喔！！
    
    fileprivate func runDataProtection() {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            assertionFailure("Fail to get Documents URL")
            return
        }
        
        // 建立要保護的檔案
        let content = ["username":"Banana"]
        let protectedFileURL = documentsURL.appendingPathComponent("Protected.plist")
        
        (content as NSDictionary).write(to: protectedFileURL, atomically: true)
        
        // 建立不被保護的檔案
        let unprotectedFileURL = documentsURL.appendingPathComponent("Unprotected.plist")
        (content as NSDictionary).write(to: unprotectedFileURL, atomically: true)
        
        // 將 Unprotected.plist 設為 不被保護
        let attributes = [FileAttributeKey.protectionKey: FileProtectionType.none]
        
        do {
            try FileManager.default.setAttributes(attributes, ofItemAtPath: unprotectedFileURL.path)
        } catch {
            print("Set attribute fail: \(error)")
        }
    }
}

//MARK:- LOCAL AUTHENTICATION
extension ViewController {
    fileprivate func runLocalAuthentication() {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            print("使用者已經設好 Biometrics")
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "....") { (isGranted, error) in
                if isGranted {
                    print("使用者允許使用生物辨別")
                } else {
                    print("使用這不允許使用生物辨別")
                }
            }
        }
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            print("使用者已經設定好 passcode")
        } else {
            print("使用者尚未設好 passcode")
        }
        
    }
}


//MARK:- Struct SimplePackage
struct SimplePackage: Decodable {
    let username:   String
    let pw:         String
    let timestamp:  String
}
