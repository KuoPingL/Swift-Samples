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
    }
}
