//
//  ChatRoomCollectionViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/10.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ChatRoomCollectionViewController: UICollectionViewController {
    public var delegate: ChatRoomListControllerDelegate?
    private var devices:[Device] = []
    private var i: CGFloat = 5.0
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func loadView() {
        super.loadView()
        collectionView.register(ChatRoomCollectionViewCell.self, forCellWithReuseIdentifier: ChatRoomCollectionViewCell.cellID)
        collectionView.backgroundColor = .white
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatRoomCollectionViewCell.cellID, for: indexPath) as? ChatRoomCollectionViewCell
        
        if cell == nil {
            cell = ChatRoomCollectionViewCell(frame: .zero)
        }
        
        cell?.layer.cornerRadius = 10.0
        cell?.layer.masksToBounds = true
        cell?.bleData = devices[indexPath.row].name
        
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(devices[indexPath.row])
    }
}

extension ChatRoomCollectionViewController: ChatRoomListDelegate {
    func reloadData(_ devices: [Device]) {
        self.devices = devices
        print("DEVICES : \(devices)")
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ChatRoomCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // iPad
        let size = collectionView.bounds.size
        
        let width = size.width / 4.0
        
        return CGSize(width: width, height: width * 1.5)
    }
}
