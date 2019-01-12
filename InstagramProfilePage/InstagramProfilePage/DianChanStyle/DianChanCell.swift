//
//  DianChanCell.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol DianChanCellProtocol: NSObjectProtocol {
    func attachHostView(_ hostView: UIView)
    func removeHostView()
    var hostView: UIView? {get set}
}

class DianChanCell: UICollectionViewCell, DianChanCellProtocol {
    
    var hostView: UIView?
    
    func attachHostView(_ hostView: UIView) {
        self.hostView = hostView
        hostView.frame = contentView.bounds
        self.contentView.addSubview(hostView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeHostView()
    }
    
    func removeHostView() {
        self.hostView?.removeFromSuperview()
        self.hostView = nil
    }
    
    
}


