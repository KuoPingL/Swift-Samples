//
//  ChatCell.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleChatCell: UITableViewCell {
    static let cellID = "CHAT_CELL"
    var chat: SimpleChatModel? {
        didSet {
            guard let chat = chat else {
                return
            }
            
            if chat.message.isEmpty {
                
            } else {
                textLabel?.text = chat.message
                textLabel?.numberOfLines = 0
                isSender = chat.isSender
            }
        }
    }
    
    var isSender: Bool = false {
        didSet {
            
            containerViewConstraint?.isActive = false
            if isSender {
                containerViewConstraint = containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)

                DispatchQueue.main.async {
                    self.textLabel?.textColor = .black
                    self.containerView.backgroundColor = UIColor.orange
                }

            } else {
                containerViewConstraint = containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
                DispatchQueue.main.async {
                    self.textLabel?.textColor = .white
                    self.containerView.backgroundColor = UIColor.black
                }
            }
            containerViewConstraint?.isActive = true
        }
    }
    
    private lazy var customizedLabel: UILabel = {
        return UILabel()
    }()
    
    override var textLabel: UILabel? {
        get {
            return customizedLabel
        }
    }
    
    private var containerViewConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private var containerView: UIView = UIView()
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView
            .top.equalTo(contentView.top, constant: 10)
            .bottom.equalTo(contentView.bottom, constant: -10)
            .centerY.equalTo(contentView.centerY)
        if let font = textLabel?.font {
            containerView.layer.cornerRadius = (font.lineHeight + 20) / 2
            containerView.layer.masksToBounds = true
        }
        
        containerView.addSubview(textLabel!)
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.backgroundColor = .clear
        containerView
            .height.equalTo(textLabel?.height, constant: 20)
            .width.equalTo(textLabel?.width, constant: 20)
        
        textLabel?
            .centerY.equalTo(containerView.centerY)
            .centerX.equalTo(containerView.centerX)
            .width.lessThanOrEqualTo(nil, constant: contentView.bounds.width * 3.0 / 4.0)
        
        
        
//        textLabel?
////            .top.equalTo(containerView.top, constant: 10)
////            .bottom.equalTo(containerView.bottom, constant: -10)
//            .width.lessThanOrEqualTo(nil,
//                                     constant: contentView.bounds.width * 3.0 / 4.0)
    }
    
}
