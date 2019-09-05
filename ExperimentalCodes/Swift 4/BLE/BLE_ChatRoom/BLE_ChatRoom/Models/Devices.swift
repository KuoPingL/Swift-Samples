//
//  Devices.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/5.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import CoreBluetooth

struct Device {
    
    var peripheral : CBPeripheral
    var name : String
    var messages = Array<String>()
    
    init(peripheral: CBPeripheral, name:String) {
        self.peripheral = peripheral
        self.name = name
    }
}
