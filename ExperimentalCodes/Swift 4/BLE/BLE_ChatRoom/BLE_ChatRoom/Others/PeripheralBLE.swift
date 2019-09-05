//
//  PeripheralBLE.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/4.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import CoreBluetooth

class PeripheralBLE: NSObject {
    static let shared = PeripheralBLE()
    
    private var peripheralManager: CBPeripheralManager!
    private let peripheralQueueLabel = "peripheralQueue"
    private lazy var peripheralQueue: DispatchQueue = {
        return DispatchQueue(label: peripheralQueueLabel)
    }()
    
    private override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: peripheralQueue)
    }
    
    
}

extension PeripheralBLE: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
    }
}


