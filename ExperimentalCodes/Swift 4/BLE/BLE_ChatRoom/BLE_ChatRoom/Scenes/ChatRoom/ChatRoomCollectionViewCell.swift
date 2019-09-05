//
//  ChatRoomCollectionViewCell.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class ChatRoomCollectionViewCell: UICollectionViewCell, ChatRoomCellDelegate {
    
    static let cellID = "ChatRoomCollectionViewCell"
    
    public var bleData: String = "" {
        didSet {
            user.bleData = bleData
            imageView.image = user.avatar
            textLabel.text = user.name
            textLabel.backgroundColor = user.color.withAlphaComponent(0.5)
            textLabel.textColor = .black
            textLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            detailTextLabel.text = "Last Seen : \(formatter.string(from: date))"
            detailTextLabel.backgroundColor = user.color.withAlphaComponent(0.5)
        }
    }
    
    private var user: UserModel = UserModel.defaultUser()
    
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var textLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    private lazy var detailTextLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        let sideInset: CGFloat = 10.0
        textLabel
            .attachTo(view: contentView, with: .side(.left(inset: .init(top: 0, left: sideInset, bottom: 0, right: 0))))
            .attachTo(view: contentView, with: .side(.right(inset: .init(top: 0, left: 0, bottom: 0, right: -sideInset))))
            .attachTo(view: contentView, with: .side(.top(inset: .init(top: sideInset, left: 0, bottom: 0, right: 0))))
        imageView
            .attachTo(view: contentView, with: .side(.left(inset: .init(top: 0, left: sideInset, bottom: 0, right: 0))))
            .attachTo(view: contentView, with: .side(.right(inset: .init(top: 0, left: 0, bottom: 0, right: -sideInset))))
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 0).isActive = true
        detailTextLabel
            .attachTo(view: contentView, with: .side(.bottom(inset: .init(top: 0, left: 0, bottom: 0, right: 0))))
            .attachTo(view: contentView, with: .side(.left(inset: .init(top: 0, left: sideInset, bottom: 0, right: 0))))
            .attachTo(view: contentView, with: .side(.right(inset: .init(top: 0, left: 0, bottom: 0, right: sideInset))))
        detailTextLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implement")
    }
}
