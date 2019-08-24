//
//  DianChanTapCopyViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/2/15.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DianChanTapCopyViewController: UIViewController {
    private lazy var tapLabel: TapCopyLabel = {
        let l = TapCopyLabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Label Tap Me"
        l.textAlignment = .center
        return l
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(tapLabel)
        
        view.backgroundColor = .white
        
        view.addConstraints([
            tapLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            tapLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60)
            ])
    }
}

class TapCopyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        let g = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        addGestureRecognizer(g)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = text
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
}
