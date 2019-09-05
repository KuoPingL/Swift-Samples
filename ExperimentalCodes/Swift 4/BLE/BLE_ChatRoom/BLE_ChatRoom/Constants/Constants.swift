//
//  Constants.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/7.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import CoreBluetooth
struct Constants {
    static let SERVICE_UUID = CBUUID(string: "434F56C1-2011-41E8-87A8-D82349E035C3")
    static let RX_UUID = CBUUID(string: "3B66D024-2336-4F22-A980-8095F4898C42")
    static let RX_PROPERTIES: CBCharacteristicProperties = .write
    static let RX_PERMISSIONS: CBAttributePermissions = .writeable
}
