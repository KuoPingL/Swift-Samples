//
//  ChatRoomDataSource.swift
//  BLETutorial
//
//  Created by Jimmy on 2019/7/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ChatRoomDataSource: NSObject, UITableViewDataSource {
    
    private let messageCellID = "messageCell"
    private let imageCellID = "imageCell"
    private let generalCellID = "generalCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: generalCellID)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: generalCellID)
        }
        
        return cell!
    }
    
    
}
