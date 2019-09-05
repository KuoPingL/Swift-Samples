//
//  ChatRoom.swift
//  BLETutorial
//
//  Created by Jimmy on 2019/7/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class ChatRoom: UITableViewController {
    
    private var centralManagerQueue = DispatchQueue(label: "chatRoomCentralManager")
    private var peripheralManagerQueue = DispatchQueue(label: "chatRoomPeripheralManager")
    
    private var centralManager: CBCentralManager!
    private var discoveredPeripheral: CBPeripheral?
    
    // PeripheralManager
    private var peripheralManager: CBPeripheralManager!
    private var transferCharacteristic: CBMutableCharacteristic!
    private var transferService: CBMutableService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: centralManagerQueue)
        peripheralManager = CBPeripheralManager(delegate: self, queue: peripheralManagerQueue)
    }
}


extension ChatRoom: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            central.scanForPeripherals(withServices: [CBUUID(string: UUIDManager.chatRoomService.rawValue)], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        default:
            let alert = AlertManager.alert(
                .message(title: "", message: "Central State is not PowerOn", buttonType: .ok),
                okHandler: nil,
                cancelHandler: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Stop Scanning right after any peripheral is discovered
        discoveredPeripheral = peripheral
        central.stopScan()
        central.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: UUIDManager.chatRoomService.rawValue)])
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        discoveredPeripheral = nil
    }
}

extension ChatRoom: CBPeripheralDelegate {
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        
    }
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        print("Did update name : \(peripheral.name ?? "")")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid.uuidString == UUIDManager.chatRoomService.rawValue {
                    peripheral.discoverCharacteristics([CBUUID(string: UUIDManager.chatRoomCharacteristic.rawValue)], for: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid.uuidString == UUIDManager.chatRoomCharacteristic.rawValue {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
        
    }
}

extension ChatRoom: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            setupCharacteristics()
            peripheral.add(self.transferService)
        default:
            present(AlertManager.alert(.message(title: "", message: "Please turn on Bluetooth for the app to work", buttonType: .ok), okHandler: nil, cancelHandler: nil), animated: true, completion: nil)
        }
    }
    
    private func setupCharacteristics() {
        self.transferCharacteristic = CBMutableCharacteristic(type: CBUUID(string: UUIDManager.chatRoomCharacteristic.rawValue), properties: [.notifyEncryptionRequired], value: nil, permissions: [.readEncryptionRequired])
        self.transferService = CBMutableService(type: CBUUID(string: UUIDManager.chatRoomService.rawValue), primary: true)
        self.transferService.characteristics = [self.transferCharacteristic]
    }
    
   
}
