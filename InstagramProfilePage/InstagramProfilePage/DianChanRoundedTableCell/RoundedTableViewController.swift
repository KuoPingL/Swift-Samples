//
//  RoundedTableViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/2/13.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class RoundedTableViewController: UITableViewController {
    
    private let headers = ["Header 1", "Header 2", "Header 3", "Header 4", "Header 5"];
    private let cellsNumber = [1, 2, 3, 4, 5];
    
    private let cellId = "cellId";
    private let radius: CGFloat = 50;
    
    override func loadView() {
        super.loadView()
        tableView.register(RoundedCell.self, forCellReuseIdentifier: cellId)
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 30, 0)
        tableView.separatorInset = UIEdgeInsetsMake(0, 30, 0, 30)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsNumber[section];
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel();
        label.text = headers[section];
        label.numberOfLines = 0
        label.textAlignment = .center;
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? RoundedCell
        if cell == nil {
            cell = RoundedCell.init(style: .default, reuseIdentifier: cellId);
        }
        
        cell?.textLabel?.text = "\(cellsNumber[indexPath.section])"
        cell?.contentView.backgroundColor = .yellow
        return cell!
    }
    
    // 這 function 後會呼叫 cell 的 layoutSubview
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "TopCorner"
            applyTopCornersOn(cell);
            
            // 唯一的 Cell 要記得將全部的 Corner 都設為 Rounded
            if cellsNumber[indexPath.section] - 1 == 0 {
                cell.textLabel?.text = "Only Cell"
                applyAllCornersOn(cell)
            }
            
        case cellsNumber[indexPath.section] - 1:
            cell.textLabel?.text = "BottomCorner"
            applyLowerCornersOn(cell);
        default:
            normalizeCornerOn(cell);
        }
    }
    
    // 只弄上方的圓角
    private func applyTopCornersOn(_ cell: UITableViewCell) {
        normalizeCornerOn(cell)
        cell.contentView.roundCorners(corners: [.topLeft, .topRight], radius: radius);
        cell.selectedBackgroundView?.roundCorners(corners: [.topLeft, .topRight], radius: radius);
    }
    
    // 只弄下方的圓角
    private func applyLowerCornersOn(_ cell: UITableViewCell) {
        normalizeCornerOn(cell)
        cell.contentView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: radius);
        cell.selectedBackgroundView?.roundCorners(corners: [.bottomLeft, .bottomRight], radius: radius);
    }
    
    // 全部都是圓角
    private func applyAllCornersOn(_ cell: UITableViewCell) {
        cell.contentView.roundCorners(corners: .allCorners, radius: radius)
        cell.selectedBackgroundView?.roundCorners(corners: .allCorners, radius: radius)
    }
    
    // 將全部歸零
    private func normalizeCornerOn(_ cell: UITableViewCell) {
        cell.contentView.roundCorners(corners: .allCorners, radius: 0);
        cell.selectedBackgroundView?.roundCorners(corners: .allCorners, radius: 0)
    }
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
