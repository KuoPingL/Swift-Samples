//
//  StickerCell.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class StickerCell: UICollectionViewCell {
    
    public var text: String? {
        get {
            return textLabel.text
        }
        
        set {
            textLabel.text = newValue
            textLabel.isHidden = false
            imageView.isHidden = true
        }
    }
    
    public var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
            textLabel.isHidden = false
            imageView.isHidden = true
        }
    }
    
    private lazy var textLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        l.textAlignment = .center
        return l
    }()
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.attachTo(view: contentView, with: .allSides(.zero))
        imageView.attachTo(view: contentView, with: .allSides(.zero))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init(coder:) is not implemented")
    }
}
