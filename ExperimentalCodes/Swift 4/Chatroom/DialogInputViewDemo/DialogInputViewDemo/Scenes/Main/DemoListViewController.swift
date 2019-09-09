//
//  DemoListViewController.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DemoListViewController: UIViewController {
    
    private var demoListDelegate: DemoListDelegate!
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private lazy var hintLabel: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.text = "Coming Soon"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var bottomSnap: SimpleSnap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoListDelegate = DemoListDelegate(tableView: tableView, delegate: self)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView
            .top.equalTo(view.top)
            .left.equalTo(view.left)
            .bottom.equalTo(view.bottom)
            .right.equalTo(view.right)
        view.addSubview(hintLabel)
        
        hintLabel
            .centerX.equalTo(view.centerX)
        bottomSnap = hintLabel.bottom
        bottomSnap?.equalTo(view.bottom, constant: -100)
    }
}


extension DemoListViewController: DemoListDelegatePresenter {
    func didSelect(_ demo: SimpleDemos) {
        
        switch demo {
        case .useTextFieldAsInputView, .useTextViewAsFooter:
            hintLabel.isHidden = false
            self.bottomSnap?.constant = -200
            let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
                self.hintLabel.alpha = 0
                self.view.layoutIfNeeded()
            }
            
            animator.addCompletion { (position) in
                self.hintLabel.isHidden = true
                self.hintLabel.alpha = 1
                self.bottomSnap?.constant = -100
                self.view.layoutIfNeeded()
            }
            
            animator.startAnimation()
            return
        default:
            break;
        }
        
        let vc = SimpleDemoFactory.demo(demo)
        vc.title = demo.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
