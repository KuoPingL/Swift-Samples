//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/29.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    private struct Constants {
        static let topics = ["Shape Transformation"]
        static let cellId = "cellID"
        
        enum Topics: String {
            case ShapeTransformation = "Shape Transformation"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath)
        cell.textLabel?.text = Constants.topics[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ADDebug.printer("DID SELECT : \(Constants.topics[indexPath.row])")
        
        guard let topic = Constants.Topics(rawValue: Constants.topics[indexPath.row]) else {
            return
        }
        switch topic {
        case .ShapeTransformation:
            let vc = ShapeTransformController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    
}

