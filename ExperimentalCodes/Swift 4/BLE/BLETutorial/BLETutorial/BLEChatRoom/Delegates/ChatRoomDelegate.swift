//
//  ChatRoomDelegate.swift
//  BLETutorial
//
//  Created by Jimmy on 2019/7/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class ChatRoomDelegate: NSObject, UITableViewDelegate {
    public var peripherals: [CBPeripheral] = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
