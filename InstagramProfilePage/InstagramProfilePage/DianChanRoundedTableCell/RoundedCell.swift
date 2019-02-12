//
//  RoundedCell.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/2/13.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class RoundedCell: UITableViewCell {
    private let inset = UIEdgeInsetsMake(0, 16, 0, 16)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, inset)
        if let selectedBackgroundView = selectedBackgroundView {
            selectedBackgroundView.frame = UIEdgeInsetsInsetRect(selectedBackgroundView.frame, inset)
        }
    }
    
}
