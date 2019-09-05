//
//  BLEListViewController.swift
//  BLETutorial
//
//  Created by Jimmy on 2019/7/6.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import CoreBluetooth

let uuidString = "F795685B-6489-4748-A50D-82772ACE00A0"

class BLEListViewController: UITableViewController {
    private let cellID = "cellID"
    private let kTableViewReloadMaxTimeInterval = 1.0
    private let CentralManagaerQueueLabel = "centralManagerQueueLabel"
    
    private var tableViewLastReloadedDate: Date!
    
    private lazy var centralManagerQueue: DispatchQueue = {
        let q = DispatchQueue(label: CentralManagaerQueueLabel)
        return q
    }()
    
    private var centralManager: CBCentralManager!
    private var peripheralManager: CBPeripheralManager!
    private let customizedUUID = CBUUID(string: uuidString)
    private var customizedCharacteristic: CBMutableCharacteristic!
    private var customizedService: CBMutableService!
    
    private var discoveredPeripherals: [CBPeripheral] = []
    private var allDiscoveredPeripherals: [String:DiscoveredPeripheral] = [:]
    private var connectedPeripheral: CBPeripheral?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // activate central manager
        // didUpdateState will be called when centralManager is init
        // if I used lazy var, then I have to call it at least once to activate the initialization.
        centralManager = CBCentralManager(delegate: self, queue: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: Peripheral Step 2: Setup Services and Characteristics
    private func setupServicesAndCharacteristics() {
        let properties: CBCharacteristicProperties = [.read, .write, .notify]
        let permissions: CBAttributePermissions = [.readable, .writeable]
        // If value == nil (dynamic) -> When being read, didReceiveReadRequest will be triggered
        customizedCharacteristic = CBMutableCharacteristic(type: customizedUUID, properties: properties, value: nil, permissions: permissions)
        customizedService = CBMutableService(type: customizedUUID, primary: true)
        customizedService.characteristics = [customizedCharacteristic]
        
        // Publish
        peripheralManager.add(customizedService)
        
    }
    
    //MARK: Central Step 2 : Scanning
    private func scanForPeripheral() {
        let services: [CBUUID] = [CBUUID.init(string: uuidString)];
        let options: [String : Any] = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        centralManager .scanForPeripherals(withServices: services, options: options)
    }
    
    private func stopScanning() {
        centralManager.stopScan()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDiscoveredPeripherals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        let uuid = allDiscoveredPeripherals.keys.sorted()[indexPath.row]
        if let peripheralDevice = allDiscoveredPeripherals[uuid] {
            cell?.textLabel?.text = "\( peripheralDevice.peripheral.name ?? "nil") (\(peripheralDevice.peripheral.identifier.uuidString))"
            cell?.textLabel?.numberOfLines = 0
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.detailTextLabel?.text = "RSSI : " + String(peripheralDevice.rssi)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uuid = allDiscoveredPeripherals.keys.sorted()[indexPath.row]
        if let peipheralDevice = allDiscoveredPeripherals[uuid] {
            centralManager.connect(peipheralDevice.peripheral, options: nil)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension BLEListViewController: CBCentralManagerDelegate {
    //MARK: Step 1: Update State
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("didUpdate State: \(central)")
        switch central.state {
        case .poweredOn:
            print("poweron")
            scanForPeripheral()
        case .poweredOff:
            print("poweroff")
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        @unknown default:
            print("NEW STATE")
        }
        
        print("Peripheral isAdvertising : \(peripheralManager.isAdvertising)")
    }
    
    // MARK: Step 3 : Update List
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let uuid = peripheral.identifier.uuidString
        let now = Date()
        let isExisted = allDiscoveredPeripherals[uuid] != nil
        if !isExisted {
            print("didDiscoveralPeripheral : \(central) \n\t\(peripheral)\n\tadvertisementData: \(advertisementData) \n\tRSSI: \(RSSI)")
        }
        
        let discoveredPeripheral = DiscoveredPeripheral(peripheral: peripheral, rssi: RSSI.intValue, lastSeenDate: now)
        
        allDiscoveredPeripherals[uuid] = discoveredPeripheral
        
        if !isExisted || now.timeIntervalSince(tableViewLastReloadedDate) > kTableViewReloadMaxTimeInterval {
            if let services = peripheral.services {
                services.forEach { (service) in
                    print("Service : \(service)")
                }
            } else {
                print("NO SERVICES")
            }
            tableViewLastReloadedDate = now
            tableView.reloadData()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnectPeripheral: \(central) \n\t\(peripheral)")
        centralManager.stopScan()
        connectedPeripheral = peripheral
        peripheral.delegate = self
//        peripheral.discoverServices(nil)
        peripheral.discoverServices([CBUUID(string: uuidString)])
    }
    
    /*
     [CoreBluetooth] API MISUSE: <CBCentralManager: 0x283087f80> has no restore identifier but the delegate implements the centralManager:willRestoreState: method. Restoring will not be supported
 
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("willRestoreState : \(central) \n\t\(dict)")
    }
    */
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("didFailToConnectPeripheral : \(central) \n\t\(peripheral)")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("didDisconnectPeripheral: \(central) \n\t\(peripheral)")
        connectedPeripheral = nil
    }
    
}

//MARK:- CBPeripheralManagerDelegate
extension BLEListViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("peripheralManagerDidUpdateState : \(peripheral)")
        switch peripheral.state {
        case .poweredOn:
            print("poweron")
            setupServicesAndCharacteristics()
        case .poweredOff:
            print("poweroff")
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        @unknown default:
            print("NEW STATE")
        }
        
        print("Peripheral isAdvertising : \(peripheralManager.isAdvertising)")
    }
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        print("peripheralManagerIsReady toUpdateSubscribers : \(peripheral)")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheralManagerDidStartAdvertising : \(peripheral) \n\tERROR: \(String(describing: error))")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        print("peripheralManager : \(peripheral) \n\tdidReceiveRead Request : \(request)")
        // Stop the crush with this.
        peripheralManager.respond(to: request, withResult: .success)
    }
    // WARNING: <CBPeripheralManager: 0x28117c540> has no restore identifier but the delegate implements the peripheralManager:willRestoreState: method. Restoring will not be supported
//    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
//        print("peripheralManager : \(peripheral) \n\twillRestoreState : \(dict)")
//    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        print("peripheralManager : \(peripheral) \n\tdidAdd Service: \(service) \n\tError: \(String(describing: error))")
        
        if error == nil {
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [service.uuid]])
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("peripheralManager : \(peripheral) \n\tdidReceiveWrite Requests : \(requests)")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didOpen channel: CBL2CAPChannel?, error: Error?) {
        print("\(#function) : \(peripheral) \n\tChannel : \(String(describing: channel)) \n\tError : \(String(describing: error))")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didPublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
        print("\(#function) : \(peripheral) \n\tPSM : \(PSM) \n\tError : \(String(describing: error))")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didUnpublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
        print("\(#function) : \(peripheral) \n\tPSM : \(PSM) \n\tError : \(String(describing: error))")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("\(#function) : \(peripheral) \n\t Central: \(central) \n\tTo Characteristic : \(characteristic)")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("\(#function) : \(peripheral) \n\t Central: \(central) \n\tFrom Characteristic : \(characteristic)")
    }
}

func logMessage(_ message: String,
                fileName: String = #file,
                functionName: String = #function,
                lineNumber: Int = #line,
                columnNumber: Int = #column) {
    
    print("Called by \(fileName) - \(functionName) at line \(lineNumber)[\(columnNumber)]")
}

//MARK:- CBPeripheralDelegate
extension BLEListViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("\(#function)")
        if let e = error {
            print("ERROR : \(e.localizedDescription)")
        }
        if let services = peripheral.services {
            for service in services {
                print("SERVICES : \(service)")
                print("CHARAC : \(service.characteristics)")
                if let characteristics = service.characteristics {
                    for characteristic in characteristics {
                        print("Characteristic : \(characteristic) \nValue : \(characteristic.value)")
                    }
                }
                
                if service.uuid.uuidString == uuidString {
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("\(#function)")
        for service in invalidatedServices {
            print("SERVICE : \(service)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("\(#function)")
        check(error)
        print("SERVICES : \(service)")
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Characteristic : \(characteristic)")
                if characteristic.properties.contains(.read) {
                    peripheral.readValue(for: characteristic)
                }
            }
        }
        
        
    }
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        print("\(#function)")
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print("\(#function)")
        check(error)
        print("DESCRIPTOR : \(descriptor)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("CHARACTERISTIC : \(#function)")
        print("CHARACTERISTIC : \(characteristic)")
        check(error)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print("\(#function)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("\(#function)")
    }
    
    func check(_ error: Error?) {
        assert(error == nil, error?.localizedDescription ?? "")
    }
}
