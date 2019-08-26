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
    
    private var item: UIView
    private var attribute: AnyObject
    
    init(item: UIView, _ attribute: AnyObject) {
        self.item = item
        self.attribute = attribute
    }
    
    @discardableResult func equalTo(_ snap: SimpleSnap?, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> UIView {
        
        var constraint: NSLayoutConstraint?
        
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
            attribute.constraint(equalToConstant: constant)
        }
        
        constraint?.isActive = true
        return item
    }
    
    @discardableResult func greaterThanOrEqualTo(_ snap: SimpleSnap?, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> UIView {
        var constraint: NSLayoutConstraint?
        
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
            attribute.constraint(greaterThanOrEqualToConstant: constant)
        }
        
        constraint?.isActive = true
        return item
    }
    
    @discardableResult func lessThanOrEqualTo(_ snap: SimpleSnap?, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> UIView {
        var constraint: NSLayoutConstraint?
        
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
            attribute.constraint(greaterThanOrEqualToConstant: constant)
        }
        
        constraint?.isActive = true
        return item
    }
    
}

extension UIView {
    
    var top: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.topAnchor)
        }
    }
    
    var bottom: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.bottomAnchor)
        }
    }
    
    var left: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.leftAnchor)
        }
    }
    
    var right: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.rightAnchor)
        }
    }
    
    var centerX: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.centerXAnchor)
        }
    }
    
    var centerY: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.centerYAnchor)
        }
    }
    
    var leading: SimpleSnap {
        get {
            return SimpleSnap(item: self, self.safeAreaLayoutGuide.leadingAnchor)
        }
    }
    
    var trailing: SimpleSnap {
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
    
////    func topTo(_ item: )
//    func test() {
//        self.widthAnchor
//    }
//
//    enum Constraints {
//        case allSides(insets: UIEdgeInsets)
//        case centered(x: CenterConstraints, y: CenterConstraints)
//        case side(SideConstraints)
//        case ratio(RatioConstraints)
//    }
//
//    enum CenterConstraints {
//        case centerX(_ dx: CGFloat, _ condition: ConstraintConditions)
//        case centerY(_ dy: CGFloat, _condition: ConstraintConditions)
//    }
//
//    enum SideConstraints {
//        case left(_ inset: CGFloat, _ condition: ConstraintConditions)
//        case right(_ inset: CGFloat, _ condition: ConstraintConditions)
//        case top(_ inset: CGFloat, _ condition: ConstraintConditions)
//        case bottom(_ inset: CGFloat, _ condition: ConstraintConditions)
//    }
//
//    enum RatioConstraints {
//        case height(multiplier: CGFloat, _ condition: ConstraintConditions)
//        case height(constant: CGFloat, _ condition: ConstraintConditions)
//        case height(multipler: CGFloat, _ constant: CGFloat, condition: ConstraintConditions)
//        case width(multipler: CGFloat, _ condition: ConstraintConditions)
//        case width(constant: CGFloat, _ condition: ConstraintConditions)
//        case width(multipler: CGFloat, _ constant: CGFloat, condition: ConstraintConditions)
//    }
//
//    enum ConstraintConditions {
//        case lessThanOrEqualTo(CGFloat)
//        case greaterThanOrEqualTo(CGFloat)
//        case equalTo(CGFloat)
//    }
//
//    @discardableResult func constraintTo(_ view: UIView?, with constraint: Constraints) -> UIView {
//
//        if self.translatesAutoresizingMaskIntoConstraints {
//            self.translatesAutoresizingMaskIntoConstraints.toggle()
//        }
//        self.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: <#T##NSLayoutXAxisAnchor#>, multiplier: <#T##CGFloat#>)
//        var newConstraints = [NSLayoutConstraint]()
//
//        switch constraint {
//        case .allSides(insets: let insets):
//            guard let view = view else {
//                return self
//            }
//            newConstraints =
//                [
//                    self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
//                    self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
//                    self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
//                    self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
//            ]
//
//        case .centered(x: let centerXConstraint, y: let centerYConstraint):
//            guard let view = view else {
//                return self
//            }
//
//            switch centerXConstraint {
//            case .centerX(let dx, let condition):
//
//            default:
//                break;
//            }
//
//            newConstraints =
//                [
//                    self.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: x),
//                    self.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: y)
//            ]
//        case .side(let sideConstraints):
//            guard let view = view else {
//                return self
//            }
//            switch sideConstraints {
//            case .bottom(let inset):
//                newConstraints = [self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: inset)]
//            case .left(let inset):
//                newConstraints = [self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset)]
//            case .right(let inset):
//                newConstraints = [self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: inset)]
//            case .top(let inset):
//                newConstraints = [self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset)]
//
//            }
//        case .ratio(let ratioConstraints):
////            if let view = view {
////                switch ratioConstraints {
////                case .height(constant: let constant):
////                    newConstraints = [self.heightAnchor.constra]
////                }
////            } else {
////
////            }
//        }
//
//        view?.addConstraints(newConstraints)
//
//        return self
//    }
}



