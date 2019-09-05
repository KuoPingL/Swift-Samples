//
//  Images.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum Avatars : Int {
        case Male_Bold
        case Male_Handsome
        case Male_ShortHair
        case Male_Punk
        case Female_LongCurlyHair
        case Female_ShortHair
        case Female_LongStraightenHair
        case Female_ShortCurlyHair
        case None
        
        var image: UIImage? {
            get {
                return UIImage(named: name, in: nil, compatibleWith: nil)
            }
        }
        
        var name: String {
            get {
                var name = ""
                switch self {
                case .Male_Bold:
                    name = "Avatar_A"
                case .Male_Handsome:
                    name = "Avatar_B"
                case .Male_ShortHair:
                    name = "Avatar_C"
                case .Male_Punk:
                    name = "Avatar_D"
                case .Female_LongCurlyHair:
                    name = "Avatar_E"
                case .Female_ShortHair:
                    name = "Avatar_F"
                case .Female_LongStraightenHair:
                    name = "Avatar_G"
                case .Female_ShortCurlyHair:
                    name = "Avatar_H"
                default:
                    break;
                }
                return name
            }
        }
        
        static func all() -> [Avatars] {
            return [.Male_Bold,
                    .Male_Handsome,
                    .Male_ShortHair,
                    .Male_Punk,
                    .Female_LongCurlyHair,
                    .Female_ShortHair,
                    .Female_LongStraightenHair,
                    .Female_ShortCurlyHair]
        }
        
        static func allDictionary() -> [String: UIImage?] {
            return [
                Avatars.Male_Bold.name:
                    UIImage.avatar(.Male_Bold),
                Avatars.Male_Handsome.name: UIImage.avatar(.Male_Handsome),
                Avatars.Male_ShortHair.name: UIImage.avatar(.Male_ShortHair),
                Avatars.Male_Punk.name:
                    UIImage.avatar(.Male_Punk),
                Avatars.Female_LongCurlyHair.name: UIImage.avatar(.Female_LongCurlyHair),
                Avatars.Female_ShortHair.name: UIImage.avatar(.Female_ShortHair),
                Avatars.Female_LongStraightenHair.name: UIImage.avatar(.Female_LongStraightenHair),
                Avatars.Female_ShortCurlyHair.name: UIImage.avatar(.Female_ShortCurlyHair)]
        }
    }
    class func avatar(_ avatars: Avatars) -> UIImage? {
        return UIImage(named: avatars.name, in: nil, compatibleWith: nil)
    }
    
    static var send: UIImage? {
        return UIImage(named: "Send", in: nil, compatibleWith: nil)
    }
    
    static var microphone: UIImage? {
        return UIImage(named: "Microphone", in: nil, compatibleWith: nil)
    }
    
    static var bubble: UIImage? {
        return UIImage(named: "Bubble", in: nil, compatibleWith: nil)
    }
    
    static var bubbleReceived: UIImage? {
        return UIImage(named: "Bubble_Received", in: nil, compatibleWith: nil)
    }
}
