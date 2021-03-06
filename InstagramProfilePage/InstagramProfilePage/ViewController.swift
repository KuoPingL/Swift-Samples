//
//  ViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/10.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

enum InstagramProfilePageStyles: String {
    case
    dianChanStyle = "典昌 Style",
    dianChanSimplifiedStyle = "典昌 Simplified Style",
    dianChanCollectionView = "典昌 Style CollectionView",
    dianChanRoundedTableView = "典昌 Rounded TableView",
    dianChanTapLabels = "典昌 Tap Labels",
    dianChanVideoCollectionView = "典昌 Video CollectionView",
<<<<<<< HEAD
    dianChanCollectionViewInScrollView = "典昌 CollectionView in ScrollView",
    simpleCollectionView = "Simple CollectionView Style"
    
    static let list: [InstagramProfilePageStyles] = [dianChanStyle, dianChanSimplifiedStyle, dianChanCollectionView, dianChanRoundedTableView, dianChanTapLabels, dianChanVideoCollectionView,dianChanCollectionViewInScrollView,simpleCollectionView]
=======
    simpleCollectionView = "Simple CollectionView Style"
    
    static let list: [InstagramProfilePageStyles] = [dianChanStyle, dianChanCollectionView, dianChanRoundedTableView, dianChanTapLabels, dianChanVideoCollectionView, simpleCollectionView]
>>>>>>> f4ad160d6ce6852502c9558001718e4cd0fe698e
}

class ViewController: UITableViewController {
    
    private let cellId = "cellId"
    private let lists = InstagramProfilePageStyles.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let style = lists[indexPath.row]
        cell.textLabel?.text = style.rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let style = lists[indexPath.row]
        switch style {
        case .dianChanStyle:
            let vc = DianChanViewController()
//            self.present(vc, animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
            break;
        case .dianChanSimplifiedStyle:
            let vc = DianChanSimplifiedViewController()
            navigationController?.pushViewController(vc, animated: true)
            break;
        case .dianChanCollectionView:
            let vc = DianChanCollectionViewController.init(collectionViewLayout: .init())
            navigationController?.pushViewController(vc, animated: true)
        case .dianChanRoundedTableView:
            let vc = RoundedTableViewController.init(style: .plain)
            navigationController?.pushViewController(vc, animated: true)
        case .dianChanTapLabels:
            let vc = DianChanTapCopyViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .dianChanVideoCollectionView:
            let vc = DianChanVideosViewController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(vc, animated: true)
<<<<<<< HEAD
        case .dianChanCollectionViewInScrollView:
            let vc = CollectionViewInScrollViewController()
            navigationController?.pushViewController(vc, animated: true)
=======
>>>>>>> f4ad160d6ce6852502c9558001718e4cd0fe698e
        case .simpleCollectionView:
            
            break;
        }
    }
}

