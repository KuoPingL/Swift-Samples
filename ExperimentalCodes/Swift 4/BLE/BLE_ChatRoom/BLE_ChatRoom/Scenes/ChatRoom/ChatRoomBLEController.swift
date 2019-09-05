//
//  ChatRoomBLEController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/10.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import CoreBluetooth
import UIKit

protocol ChatroomBLEControllerDelegate: UIViewController {
    func didUpdateDevices(_ devices: [Device])
}

final class ChatRoomBLEController: NSObject {
    weak public var delegate: ChatroomBLEControllerDelegate?
    
    // Central to Find Peripheral
    private var centralQueue = DispatchQueue(label: "central")
    private var centralManager : CBCentralManager!
    
    // Peripheral to Advertise
    private var peripheralQueue = DispatchQueue(label: "peripheral")
    private var peripheralManager : CBPeripheralManager!
    
    // Peripheral instances
    public var visibleDevices: [Device] = []
    private var cachedDevices: [Device] = []
    
    // Timer to clean Peripherals
    private var peripheralCleanerTimer: Timer?
    
    convenience init(delegate: ChatroomBLEControllerDelegate?) {
        self.init()
        self.delegate = delegate
    }
    
    private func updateAdvertisingData () {
        if (peripheralManager.isAdvertising) {
            peripheralManager.stopAdvertising()
        }
        
//        let user = UserModel()
//        let service = CBMutableService(type: Constants.SERVICE_UUID, primary: true)
//        let data = String(format: "%@|%@|%f|%f|%f", user.name, user.avatarType.rawValue, user.red, user.green, user.blue).data(using: .utf8)
//        let characteristics = [CBMutableCharacteristic(type: Constants.RX_UUID, properties: Constants.RX_PROPERTIES, value: data, permissions: Constants.RX_PERMISSIONS)]
//        service.characteristics = characteristics
//        peripheralManager.add(service)
        
        // Simply advertise the service UUIDs and DataLocalName
        var user = UserModel()
        let data = user.bleData
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [Constants.SERVICE_UUID], CBAdvertisementDataLocalNameKey: data])
    }
    
    public func refreshBLE() {
        cachedDevices.removeAll()
        visibleDevices.removeAll()
        delegate?.didUpdateDevices(visibleDevices)
        centralManagerDidUpdateState(centralManager)
    }
    
    public func activateBLE() {
        scheduledTimerWithTimeInterval()
        if !centralManager.isScanning && centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [Constants.SERVICE_UUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }
        
        updateAdvertisingData()
    }
    // no need to stop advertising so others know you are here.
    public func deactivateBLE() {
        centralManager.stopScan()
        peripheralCleanerTimer?.invalidate()
        peripheralCleanerTimer = nil
    }
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self,
                                          queue: centralQueue)
        peripheralManager = CBPeripheralManager(delegate: self,
                                                queue: peripheralQueue)
        scheduledTimerWithTimeInterval()
    }
    
    // a timer that clears all the cachedDevices every 10 seconds.
    private func scheduledTimerWithTimeInterval(){
        peripheralCleanerTimer?.invalidate()
        peripheralCleanerTimer = nil
        peripheralCleanerTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.clearPeripherals), userInfo: nil, repeats: true)
    }
    
    @objc func clearPeripherals(){
        visibleDevices = cachedDevices
        cachedDevices.removeAll()
        delegate?.didUpdateDevices(visibleDevices)
    }
    
}

extension ChatRoomBLEController: CBCentralManagerDelegate {
    //MARK: Step 1:
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn else {
            print("Central is currently off")
            return
        }
        // start scanning
        // The value for this key is an NSNumber object.
        // If true, filtering is disabled and a discovery event is generated each time the central receives an advertising packet from the peripheral.
        // Disabling this filtering can have an adverse effect on battery life and should be used only if necessary. If false, multiple discoveries of the same peripheral are coalesced into a single discovery event. If the key is not specified, the default value is false.
        
        centralManager.scanForPeripherals(withServices: [Constants.SERVICE_UUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    //MARK: Step 2
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var peripheralName = "unknown"
        
        if let advertisementName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = advertisementName
        }
        
        let device = Device(peripheral: peripheral, name: peripheralName)
        addOrUpdatePeripheralList(device: device, list: &cachedDevices)
        addOrUpdatePeripheralList(device: device, list: &visibleDevices, shouldReload: true)
    }
    
    // Check if the device is in the list (Matching Peripheral Identifier and Name)
    private func addOrUpdatePeripheralList(device: Device, list: inout Array<Device>, shouldReload: Bool = false) {
        
        if !list.contains(where: {
            $0.peripheral.identifier == device.peripheral.identifier
        }) {
            // If the list does not contain such device, append and reload
            list.append(device)
            if shouldReload {
                delegate?.didUpdateDevices(list)
            }
        } else {
            
            // check if the name is the same, if not update and reload
            for i in 0..<list.count {
                if list[i].peripheral.identifier == device.peripheral.identifier {
                    list[i].name = device.name
                    if shouldReload {
                        delegate?.didUpdateDevices(list)
                    }
                    break
                }
            }
            
        }
        
    }
}

extension ChatRoomBLEController: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        guard peripheral.state == .poweredOn else {
            if let delegate = delegate {
                AlertHelper.warn(delegate: delegate, message: "Please turn on Bluetooth")
            }
            return
        }
        updateAdvertisingData()
    }
}
