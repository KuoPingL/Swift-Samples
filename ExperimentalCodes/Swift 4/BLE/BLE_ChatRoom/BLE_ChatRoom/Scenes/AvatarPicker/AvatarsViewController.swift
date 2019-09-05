//
//  AvatorsViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol AvatarsViewControllerDelegate {
    func didSelect(avator: UIImage.Avatars)
    func didPressedDoneButton()
}

class AvatarsViewController: UIViewController {
    public var delegate: AvatarsViewControllerDelegate?
    
    public var avators: [UIImage.Avatars] {
        get {
            return data
        }
        
        set{
            data = newValue
        }
    }
    
    private var data: [UIImage.Avatars] = [] {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    private var keys: [String] = []
    private var selectedIndex: IndexPath?
    private var selectedAvatar: UIImage.Avatars = .None
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        return l
    }()
    
    private lazy var doneButton: UIButton = {
        let b = UIButton()
        b.setTitle("_done", for: .normal)
        b.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    @objc private func doneButtonPressed(_ sender: UIButton) {
        delegate?.didPressedDoneButton()
    }
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        v.delegate = self
        v.dataSource = self
        v.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        v.backgroundColor = .clear
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.attachTo(view: view, with: .corner(.topRight(insets: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -10))))
        collectionView
            .attachTo(view: view, with: .side(.bottom(inset: .zero)))
            .attachTo(view: view, with: .side(.left(inset: .zero)))
            .attachTo(view: view, with: .side(.right(inset: .zero)))
        collectionView.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 10).isActive = true
        collectionView.register(AvatorCell.self, forCellWithReuseIdentifier: AvatorCell.cellID)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent != nil, let index = selectedIndex {
            collectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}


extension AvatarsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedAvatar == data[indexPath.row] {
            return
        }
        
        if let index = selectedIndex {
            let cell = collectionView.cellForItem(at: index)
            cell?.isSelected = false
        }
        
        selectedIndex = indexPath
        selectedAvatar = data[indexPath.row]
        delegate?.didSelect(avator: selectedAvatar)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 20
        return CGSize(width: height, height: height)
    }
}

extension AvatarsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatorCell.cellID, for: indexPath) as? AvatorCell
        if cell == nil {
            cell = AvatorCell(frame: .zero)
        }
        
        let avatar = data[indexPath.row]
        cell?.image = avatar.image
        
        if avatar == selectedAvatar {
            cell?.isSelected = true
        } else {
            cell?.isSelected = false
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}
