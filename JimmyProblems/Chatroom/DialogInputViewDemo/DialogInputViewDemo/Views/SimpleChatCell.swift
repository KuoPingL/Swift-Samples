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
            
            textLabelConstraint?.isActive = false
            if isSender {
                textLabelConstraint = textLabel?.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
                
                DispatchQueue.main.async {
                    self.textLabel?.textColor = .black
                    self.textLabel?.backgroundColor = UIColor.orange
                }
                
            } else {
                textLabelConstraint = textLabel?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
                DispatchQueue.main.async {
                    self.textLabel?.textColor = .white
                    self.textLabel?.backgroundColor = UIColor.black
                }
            }
            textLabelConstraint?.isActive = true
        }
    }
    
    private lazy var customizedLabel: UILabel = {
        return InsetUILabel()
    }()
    
    override var textLabel: UILabel? {
        get {
            return customizedLabel
        }
    }
    
    private var textLabelConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(textLabel!)
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.layer.cornerRadius = 15.0
        textLabel?.layer.masksToBounds = true
        textLabel?
            .top.equalTo(contentView.top_safeAreaLayoutGuid,
                         constant: 10)
            .bottom.equalTo(contentView.bottom_safeAreaLayoutGuide,
                            constant: -10)
            .width.lessThanOrEqualTo(nil,
                                     constant: contentView.bounds.width * 3.0 / 4.0)
    }
    
}
