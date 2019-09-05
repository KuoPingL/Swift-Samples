//
//  ConservationBLEController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/17.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

protocol ConversationBLEControllerDelegate: AnyObject {
    func showBLEAlert(_ alert: UIAlertController)
}

class ConversationBLEController: NSObject {
    public weak var delegate: ConversationBLEControllerDelegate?
    
    private var devices: [Device] = []
    
    // Central to Find Peripheral
    private var centralQueue = DispatchQueue(label: "central")
    private var centralManager : CBCentralManager!
    
    // Peripheral to Advertise
    private var peripheralQueue = DispatchQueue(label: "peripheral")
    private var peripheralManager : CBPeripheralManager!
    
    public func connectToDevices(_ devices: [Device]) {
        self.devices = devices
        if centralManager.state == .poweredOn {
            for device in self.devices {
                centralManager.connect(device.peripheral, options: nil)
            }
        } else {
            print("Current Device not power on")
        }
    }
    
    public func sendMessage(_ message: Message, to devices: [Device]) {
        
        if centralManager.retrieveConnectedPeripherals(withServices: [Constants.SERVICE_UUID]).count == 0 || devices.count == 0 || centralManager.state != .poweredOn {
            delegate?.showBLEAlert(AlertHelper.warn(delegate: nil, message: "Please make sure BLE is connected properly."))
            return
        }
        guard !message.text.isEmpty, let data = message.text.data(using: .utf8) else {
            delegate?.showBLEAlert(AlertHelper.warn(delegate: nil, message: "Invalid String Found"))
            return
        }
        
        for device in devices {
            let peripheral = device.peripheral
            let characteristic = CBMutableCharacteristic(type: Constants.RX_UUID, properties: Constants.RX_PROPERTIES, value: nil, permissions: Constants.RX_PERMISSIONS)
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
        }
    }
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
        peripheralManager = CBPeripheralManager(delegate: self, queue: peripheralQueue)
    }
}

extension ConversationBLEController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            connectToDevices(devices)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        central.cancelPeripheralConnection(peripheral)
        print("Failed to connect to \(peripheral.name ?? "unknown")")
    }
}


extension ConversationBLEController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        initServices()
    }
    
    private func initServices() {
        let service = CBMutableService(type: Constants.RX_UUID, primary: true)
        // Writable
        let characteristics = [CBMutableCharacteristic(type: Constants.RX_UUID, properties: Constants.RX_PROPERTIES, value: nil, permissions: Constants.RX_PERMISSIONS)]
        service.characteristics = characteristics
        peripheralManager.add(service)
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
    }
    
}

extension ConversationBLEController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
    }
}
