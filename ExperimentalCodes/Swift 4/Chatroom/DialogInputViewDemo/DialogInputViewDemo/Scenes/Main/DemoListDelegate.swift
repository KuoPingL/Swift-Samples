//
//  DemoListDataSource.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol DemoListDelegatePresenter: UIViewController {
    func didSelect(_ demo: SimpleDemos)
}

class DemoListDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private weak var tableView: UITableView?
    private weak var delegate: DemoListDelegatePresenter?
    private var demos: [[String]] = Demo.demos
    private let cellID = "Demos"
    
    
    init(tableView: UITableView, delegate: DemoListDelegatePresenter) {
        super.init()
        self.tableView = tableView
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        
        let text = (demos[indexPath.section])[indexPath.row]
        cell?.textLabel?.text = text
        cell?.textLabel?.numberOfLines = 0
        if let textLabel = cell?.textLabel, textLabel.translatesAutoresizingMaskIntoConstraints {
            cell?.textLabel?.translatesAutoresizingMaskIntoConstraints = false
            cell?.textLabel?
                .leading.equalTo(cell?.contentView.leading, constant: 20)
                .top.equalTo(cell?.contentView.top, constant: 10)
                .bottom.equalTo(cell?.contentView.bottom, constant: -10)
                .trailing.equalTo(cell?.contentView.trailing)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Demo.demoTitles[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.attributedText = NSAttributedString(string: Demo.demoTitles[section], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .heavy), NSAttributedString.Key.foregroundColor: UIColor.blue])
        label.numberOfLines = 0
        label.sizeToFit()
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label
            .top.equalTo(view.top)
            .bottom.equalTo(view.bottom)
            .left.equalTo(view.left, constant: 10)
            .right.equalTo(view.right, constant: -10)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let description = (demos[indexPath.section])[indexPath.row]
        Demo.demosWithDescription(description) { (simpleDemo) in
            delegate?.didSelect(simpleDemo)
            DispatchQueue.main.async {
                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }
}
