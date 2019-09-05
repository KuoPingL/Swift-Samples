//
//  UserModel.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

struct UserModel {
    var red: CGFloat = 238
    var green: CGFloat = 181
    var blue: CGFloat = 29
    var color: UIColor {
        get {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        }
        set {
            
            if let rgb = newValue.cgColor.components {
                red = rgb[0] * 255.0
                green = rgb[1] * 255.0
                blue = rgb[2] * 255.0
            }
            
        }
    }
    
    var avatar: UIImage? {
        get {
            return UIImage.avatar(avatarType)
        }
    }
    var avatarType: UIImage.Avatars  = .None {
        didSet {
            print(avatarType.rawValue)
        }
    }
    
    var bleData: String {
        mutating get {
            print("STRING : ")
            print(String(format: "%@|%d|%.03f|%.03f|%.03f", name, avatarType.rawValue, red / 255.0, green / 255.0, blue / 255.0))
            print(String(format: "%@|%d|%.03f|%.03f|%.03f", name, avatarType.rawValue, red/255.0, green/255.0, blue/255.0).lengthOfBytes(using: .utf8))
            let components = String(format: "%@|%d|%.03f|%.03f|%.03f", name, avatarType.rawValue, red / 255.0, green / 255.0, blue / 255.0).components(separatedBy: "|")
            print(components)
            return String(format: "%@|%d|%.03f|%.03f|%.03f", name, avatarType.rawValue, red / 255.0, green / 255.0, blue / 255.0)
        }
        
        set {
            print("NEw VALUE")
            print(newValue)
            print(newValue.lengthOfBytes(using: .utf8))
            let components = newValue.components(separatedBy: "|")
            print(components)
            guard components.count == 5 else {
                let user = UserModel.defaultUser()
                self.name = user.name
                self.avatarType = user.avatarType
                self.color = user.color
                return
            }
            
            name = components[0]
            avatarType = UIImage.Avatars(rawValue: components[1].intValue) ?? .None
            red = components[2].cgFloatValue * 255.0
            green = components[3].cgFloatValue * 255.0
            blue = components[4].cgFloatValue * 255.0
        }
    }
    
    var name: String = ""
    
    private let userKey = "user"
    private let nameKey = "name"
    private let avatarTypeKey = "avatarType"
    private let colorKey = "color"
    
    public var isDataComplete: Bool {
        get {
            if name.isEmpty {
                print("User info missing Name")
                return false
            }
            
            if avatarType == .None {
                print("User info missing Avatar Type")
                return false
            }
            
            return true
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.dictionary(forKey: userKey) {
            name = savedData[nameKey] as? String ?? ""
            let avatar = savedData[avatarTypeKey] as? Int ?? 1000
            avatarType = UIImage.Avatars(rawValue: avatar) ?? .None
            
            if let colorData = savedData[colorKey] as? Data {
                color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? color
            }
        }
    }
    
    public func save() {
        var saveData = [String : Any]()
        saveData[nameKey] = name
        print("SAVING : \(avatarType.rawValue)")
        saveData[avatarTypeKey] = avatarType.rawValue
        // 'Attempt to insert non-property list object'
        saveData[colorKey] = NSKeyedArchiver.archivedData(withRootObject: color)
        UserDefaults.standard.set(saveData, forKey: userKey)
    }
    
    public mutating func clear() {
        UserDefaults.standard.set(nil, forKey: userKey)
        name = ""
        red = 238
        green = 181
        blue = 29
        avatarType = .None
    }
    
    static func defaultUser() -> UserModel {
        var user = UserModel()
        let red: CGFloat = 238
        let green: CGFloat = 181
        let blue: CGFloat = 29
        user.color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        user.name = "unknown"
        user.avatarType = .None
        return user
    }
}
