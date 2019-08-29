//
//  UIViewExtension.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class SimpleSnap {
    
    public var constant: CGFloat {
        get {
            return constraint?.constant ?? 0
        }
        
        set {
            constraint?.constant = newValue
        }
    }
    
    private var constraint: NSLayoutConstraint?
    private var item: UIView
    private var attribute: AnyObject
    
    init(item: UIView, _ attribute: AnyObject) {
        self.item = item
        self.attribute = attribute
    }
    
    @discardableResult func equalTo(_ snap: SimpleSnap?, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> UIView {
        
        if let snap = snap {
            if let attribute = attribute as? NSLayoutDimension,
                let snapAttribute = snap.attribute as? NSLayoutDimension {
                constraint = attribute.constraint(equalTo: snapAttribute, multiplier: multiplier, constant: constant)
            } else if
                let attribute = attribute as? NSLayoutXAxisAnchor,
                let snapAttribute = snap.attribute as? NSLayoutXAxisAnchor {
                constraint = attribute.constraint(equalTo: snapAttribute, constant: constant)
                
            } else if
                let attribute = attribute as? NSLayoutYAxisAnchor,
                let snapAttribute = snap.attribute as? NSLayoutYAxisAnchor {
                constraint = attribute.constraint(equalTo: snapAttribute, constant: constant)
            }
            
        } else if let attribute = attribute as? NSLayoutDimension {
            constraint = attribute.constraint(equalToConstant: constant)
        }
        
        constraint?.isActive = true
        return item
    }
    
    @discardableResult func greaterThanOrEqualTo(_ snap: SimpleSnap?, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> UIView {
        
        if let snap = snap {
            if let attribute = attribute as? NSLayoutDimension,
                let snapAttribute = snap.attribute as? NSLayoutDimension {
                constraint = attribute.constraint(greaterThanOrEqualTo: snapAttribute, multiplier: multiplier, constant: constant)
            } else if
                let attribute = attribute as? NSLayoutXAxisAnchor,
                let snapAttribute = snap.attribute as? NSLayoutXAxisAnchor {
                constraint = attribute.constraint(greaterThanOrEqualTo: snapAttribute, constant: constant)
                
            } else if
                let attribute = attribute as? NSLayoutYAxisAnchor,
                let snapAttribute = snap.attribute as? NSLayoutYAxisAnchor {
                constraint = attribute.constraint(greaterThanOrEqualTo: snapAttribute, constant: constant)
            }
            
        } else if let attribute = attribute as? NSLayoutDimension {
            constraint = attribute.constraint(greaterThanOrEqualToConstant: constant)
        }
        
        constraint?.isActive = true
        return item
    }
    
    @discardableResult func lessThanOrEqualTo(_ snap: SimpleSnap?, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> UIView {
        
        if let snap = snap {
            if let attribute = attribute as? NSLayoutDimension,
                let snapAttribute = snap.attribute as? NSLayoutDimension {
                constraint = attribute.constraint(lessThanOrEqualTo: snapAttribute, multiplier: multiplier, constant: constant)
            } else if
                let attribute = attribute as? NSLayoutXAxisAnchor,
                let snapAttribute = snap.attribute as? NSLayoutXAxisAnchor {
                constraint = attribute.constraint(lessThanOrEqualTo: snapAttribute, constant: constant)
                
            } else if
                let attribute = attribute as? NSLayoutYAxisAnchor,
                let snapAttribute = snap.attribute as? NSLayoutYAxisAnchor {
                constraint = attribute.constraint(lessThanOrEqualTo: snapAttribute, constant: constant)
            }
            
        } else if let attribute = attribute as? NSLayoutDimension {
            constraint = attribute.constraint(lessThanOrEqualToConstant: constant)
        }
        
        constraint?.isActive = true
        return item
    }
    
}

extension UIView {
    
    var height: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.heightAnchor)
        }
    }
    
    var width: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.widthAnchor)
        }
    }
    
    var top: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.topAnchor)
        }
    }
    
    var top_safeAreaLayoutGuid: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.topAnchor)
        }
    }
    
    var bottom: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.bottomAnchor)
        }
    }
    
    var bottom_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.bottomAnchor)
        }
    }
    
    var left: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.leftAnchor)
        }
    }
    
    var left_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.leftAnchor)
        }
    }
    
    var right: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.rightAnchor)
        }
    }
    
    var right_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.rightAnchor)
        }
    }
    
    var centerX: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.centerXAnchor)
        }
    }
    
    var centerX_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.centerXAnchor)
        }
    }
    
    var centerY: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.centerYAnchor)
        }
    }
    
    var centerY_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.centerYAnchor)
        }
    }
    
    var leading: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.leadingAnchor)
        }
    }
    
    var leading_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.leadingAnchor)
        }
    }
    
    var trailing: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.trailingAnchor)
        }
    }
    
    var trailing_safeAreaLayoutGuide: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.trailingAnchor)
        }
    }
    
    var lastBaseLine: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.lastBaselineAnchor)
        }
    }
    
    var firstBaseLine: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.firstBaselineAnchor)
        }
    }
    
    func edgeTo(_ view: UIView, with edgeInsets: UIEdgeInsets) {
        self
            .top.equalTo(view.top, constant: edgeInsets.top)
            .bottom.equalTo(view.bottom, constant: edgeInsets.bottom)
            .left.equalTo(view.left, constant: edgeInsets.left)
            .right.equalTo(view.right, constant: edgeInsets.right)
    }
}



