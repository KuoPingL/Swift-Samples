//
//  CentralBLE.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/4.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol CentralBLEDelegate {
    func centralBLEErrorMessage(_ message: String)
}

class CentralBLE: NSObject {
    
    static let shared = CentralBLE()
    
    private var centralManager: CBCentralManager!
    private let centralQueueLabel = "centralQueue"
    private lazy var centralQueue: DispatchQueue = {
        return DispatchQueue(label: centralQueueLabel)
    }()
    
    private override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
}

extension CentralBLE: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch central.state {
//        case .poweredOn:
////            central.scanForPeripherals(withServices: <#T##[CBUUID]?#>, options: <#T##[String : Any]?#>)
//        default:
//            
//        }
    }
}
