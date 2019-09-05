//
//  PeripheralModel.swift
//  BLETutorial
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import CoreBluetooth

struct DiscoveredPeripheral {
    var peripheral: CBPeripheral
    var rssi: Int
    var lastSeenDate: Date
}
