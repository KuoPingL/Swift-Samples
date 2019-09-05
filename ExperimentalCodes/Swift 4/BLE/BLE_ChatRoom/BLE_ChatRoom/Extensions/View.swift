//
//  View.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/8/2.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    enum Constraints {
        case allSides(UIEdgeInsets)
        case centered
        case side(SideConstraints)
        case corner(CornerConstraints)
    }
    
    enum SideConstraints {
        case left(inset: UIEdgeInsets)
        case right(inset: UIEdgeInsets)
        case top(inset: UIEdgeInsets)
        case bottom(inset: UIEdgeInsets)
    }
    
    enum CornerConstraints {
        case topRight(insets: UIEdgeInsets)
        case topLeft(insets: UIEdgeInsets)
        case bottomRight(insets: UIEdgeInsets)
        case bottomLeft(insets: UIEdgeInsets)
    }
    
    @discardableResult func attachTo(view: UIView, with constraints: Constraints) -> UIView {
        if self.superview == nil {
            self.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(self)
        } else if let parent = self.superview, parent != view {
            print("\(self) apparently was not attached to \(view)")
            return self
        }
        
        var newConstraints = [NSLayoutConstraint]()
        
        switch constraints {
        case .allSides(let insets):
            newConstraints =
                [
                    self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
                    self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
                    self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                    self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
            ]
        case .centered:
            newConstraints =
                [
                    self.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                    self.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0)
            ]
        case .corner(let cornerConstraints):
            switch cornerConstraints {
            case .bottomLeft(let inset):
                newConstraints =
                    [
                        self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: inset.bottom),
                        self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset.left)
                ]
            case .bottomRight(let inset):
                newConstraints =
                    [
                        self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: inset.bottom),
                        self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: inset.right)
                ]
            case .topLeft(let inset):
                newConstraints =
                    [
                        self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset.top),
                        self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset.left)
                ]
            case .topRight(let inset):
                newConstraints =
                    [
                        self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset.top),
                        self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: inset.right)
                ]
                
            }
        case .side(let sideConstraints):
            switch sideConstraints {
            case .bottom(let inset):
                newConstraints = [self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: inset.bottom)]
            case .left(let inset):
                newConstraints = [self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset.left)]
            case .right(let inset):
                newConstraints = [self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: inset.right)]
            case .top(let inset):
                newConstraints = [self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset.top)]
                
            }
        }
        
        view.addConstraints(newConstraints)
        
        return self
    }
}
