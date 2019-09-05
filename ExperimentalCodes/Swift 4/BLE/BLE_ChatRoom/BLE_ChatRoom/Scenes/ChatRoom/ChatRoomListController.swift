//
//  ChatRoomListController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/10.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol ChatRoomListControllerDelegate {
    func didSelect(_ device: Device)
    func refreshBLE()
}

protocol ChatRoomListDelegate: UIViewController {
    func reloadData(_ devices: [Device])
}

class ChatRoomListController: ChatRoomListControllerDelegate {
    public var delegate: ChatRoomListControllerDelegate?
    
    private var currentChatRoomViewController: ChatRoomListDelegate?
    
    init(delegate: ChatRoomListControllerDelegate) {
        self.delegate = delegate
    }
    
    public func getListViewController() -> ChatRoomListDelegate {
        let interfaceIdiom = UIDevice.current.userInterfaceIdiom
        switch interfaceIdiom {
        case .pad, .tv:
            let vc = ChatRoomCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.delegate = self
            currentChatRoomViewController = vc
            
        default:
            let vc = ChatRoomTableViewController(style: .plain)
            vc.delegate = self
            currentChatRoomViewController = vc
        }
        return currentChatRoomViewController!
    }
    
    func didSelect(_ device: Device) {
        delegate?.didSelect(device)
    }
    
    public func reloadData(_ devices: [Device]) {
        currentChatRoomViewController?.reloadData(devices)
    }
    
    func refreshBLE() {
        delegate?.refreshBLE()
    }
}
