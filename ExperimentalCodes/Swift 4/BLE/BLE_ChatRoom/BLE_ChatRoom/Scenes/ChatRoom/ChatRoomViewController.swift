//
//  ChatRoomViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/4.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

final class ChatRoomViewController: UIViewController {
    
    private var bleController: ChatRoomBLEController!
    private var listController: ChatRoomListController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(title: "_profile".localized, style: .done, target: self, action: #selector(showProfile))
        navigationItem.rightBarButtonItem = rightButton
        bleController = ChatRoomBLEController(delegate: self)
        listController = ChatRoomListController(delegate: self)
        setupUI()
    }
    
    @objc private func showProfile() {
        let profileVC = LoginViewController()
        profileVC.isLoginPage = false
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func setupUI() {
        let listVC = listController.getListViewController()
        listVC.willMove(toParent: self)
        listVC.view.frame = view.bounds
        view.addSubview(listVC.view)
        addChild(listVC)
        listVC.didMove(toParent: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bleController.activateBLE()
    }
}

extension ChatRoomViewController: ChatroomBLEControllerDelegate {
    func didUpdateDevices(_ devices: [Device]) {
        listController.reloadData(devices)
    }
}

extension ChatRoomViewController: ChatRoomListControllerDelegate {
    func didSelect(_ device: Device) {
//       let vc = ConversationViewController(style: .plain)
        let vc = UIViewController()
        let tv = UITableView(frame: .zero, style: .plain)
        tv.keyboardDismissMode = .onDrag
        tv.attachTo(view: vc.view, with: .allSides(.zero))
        let input = SimpleDialogInputView()
        input.attachTo(view: vc.view, with: .side(.bottom(inset: .zero))).attachTo(view: vc.view, with: .side(.left(inset: .zero))).attachTo(view: vc.view, with: .side(.right(inset: .zero)))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshBLE() {
        bleController?.refreshBLE()
    }
}
