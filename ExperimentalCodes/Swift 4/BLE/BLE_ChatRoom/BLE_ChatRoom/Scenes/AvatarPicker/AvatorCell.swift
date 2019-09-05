//
//  AvatorCell.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class AvatorCell: UICollectionViewCell {
    public static let cellID = "Avator"
    public var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    private var imageView: UIImageView!
    private var checkPath: UIBezierPath!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.green.cgColor
                layer.borderWidth = 3.0
            } else {
                layer.borderColor = UIColor.black.cgColor
                layer.borderWidth = 2.0
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2.0
        backgroundColor = .white
        layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addConstraints([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
