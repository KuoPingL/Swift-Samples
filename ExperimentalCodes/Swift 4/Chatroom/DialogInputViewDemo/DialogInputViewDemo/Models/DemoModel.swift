//
//  DemoModel.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation

enum Demo {
    case simple(SimpleDemos)
    
    static var demos: [[String]] {
        get {
            var demo = [[String]]()
            demo.append(SimpleDemos.demos)
            return demo
        }
    }
    
    static var demoTitles: [String] {
        get {
            return [SimpleDemos.title]
        }
    }
    
    static func demosWithDescription(_ description: String, simpleDemoClosure:(SimpleDemos) -> Void) {
        if let demo = SimpleDemos.demoWithDescription(description) {
            simpleDemoClosure(demo)
        }
    }
}

protocol DemoDelegate {
    var description: String {get}
    static var demos: [String] {get}
    static var title: String {get}
}

enum SimpleDemos: String, DemoDelegate {
    case useTextViewAsInputView = "Place textView as the inputView of view controller"
    case addTextViewAsSubView = "Place textView as subview onto view controller"
    case useTextFieldAsInputView = "Place textField as the inputView of view controller"
    case useTextViewAsFooter = "Place textView as Footer of UITableView"
    
    var description: String {
        get {
            return self.rawValue.localized
        }
    }
    
    static var demos: [String] {
        get {
            return
                [
                    SimpleDemos.useTextViewAsInputView.description,
                    SimpleDemos.addTextViewAsSubView.description,
                    SimpleDemos.useTextFieldAsInputView.description,
                    SimpleDemos.useTextViewAsFooter.description
            ]
        }
    }
    
    static var title: String {
        get {
            return "Simple Demos".localized
        }
    }
    
    static func demoWithDescription(_ description: String) -> SimpleDemos? {
        if description == SimpleDemos.useTextViewAsInputView.description {
            return .useTextViewAsInputView
        } else if description == SimpleDemos.useTextFieldAsInputView.description {
            return .useTextFieldAsInputView
        } else if description == SimpleDemos.addTextViewAsSubView.description {
            return .addTextViewAsSubView
        } else if description == SimpleDemos.useTextViewAsFooter.description {
            return .useTextViewAsFooter
        }
        
        return nil
    }
}
