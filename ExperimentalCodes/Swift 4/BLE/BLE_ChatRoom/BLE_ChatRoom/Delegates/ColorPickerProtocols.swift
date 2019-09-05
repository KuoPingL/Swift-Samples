//
//  ColorPickerProtocols.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/28.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
protocol ColorPickerDelegate: NSObjectProtocol {
    func didSelect(color: UIColor)
}
