//
//  ChatRoomListController.swift
//  ChatRoom
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

let cellID = "cellID"

class InputDialogListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var dataList: [InputDialog] =
        [InputDialog(name: "Basic InputView", inputContainer: DialogInputContainer())]
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private var currentContainer: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        var inputDialog = InputDialog(name: "Dummy Data", inputContainer: UIView())
        if index < dataList.count {
            inputDialog = dataList[index]
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = inputDialog.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        if dataList.count > index {
            let inputContainer = dataList[index].inputContainer
            addAndDisplayContainer()
            if currentContainer == nil {
                currentContainer = inputContainer
                DispatchQueue.main.async {[unowned self] in
                    self.addAndDisplayContainer()
                }
            } else if currentContainer! == inputContainer {
                hideAndRemoveContainer()
            } else {
                hideAndRemoveContainer()
                currentContainer = inputContainer
                addAndDisplayContainer()
            }
            
        } else {
            print("ROW_\(indexPath.row) is Dummy Data")
            hideAndRemoveContainer()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func hideAndRemoveContainer() {
        return;
        guard let container = currentContainer else {
            return
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [unowned self] in
            container.alpha = 0
            container.frame = CGRect(x: container.frame.origin.x, y: self.view.frame.height, width: container.frame.width, height: container.frame.height)
        }) {[unowned self] (complete) in
            container.removeFromSuperview()
            self.currentContainer = nil
        }
    }
    
    private func addAndDisplayContainer() {
        
        guard let container = currentContainer else {
            return
        }
        
        currentContainer?.frame = CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: 50)
        view.addSubview(currentContainer!)
        
        animate(container: container)
        
    }
    
    func animate(container: UIView) {
        let newOrigin = CGPoint(x: 0, y: self.view.frame.height - 200)
        container.alpha = 1
        UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            container.frame.origin = newOrigin
        }.startAnimation()
        
        
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [.curveLinear], animations: {[unowned self] in
////            self.view.layoutIfNeeded()
//            container.frame.origin = newOrigin//= CGRect(origin: newOrigin, size: container.frame.size)
//            //            print(container)
//            //            self.view.layoutIfNeeded()
//            }, completion: nil)
    }
}
