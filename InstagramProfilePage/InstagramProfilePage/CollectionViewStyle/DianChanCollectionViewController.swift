//
//  DianChanCollectionViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DianChanCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowlayout = DianChanCollectionViewLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 5
        flowlayout.minimumInteritemSpacing = 5
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView?.collectionViewLayout = flowlayout
        
        
//        let gridLayout = GridLayout()
//        gridLayout.scrollDirection = .vertical
//        gridLayout.fixedDivisionCount = 3 // Columns for .vertical, rows for .horizontal
//        gridLayout.itemSpacing = 5
//        collectionView?.collectionViewLayout = gridLayout
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        var color: UIColor = .red
        
        switch indexPath.row % 12 {
        case 0, 1:
            color = .red
        case 2, 3:
            color = .orange
        case 4, 5:
            color = .yellow
        case 6, 7:
            color = .green
        case 8, 9:
            color = .cyan
        case 10, 11:
            color = .blue
        default:
            break
        }
        
        cell.backgroundColor = color
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
////        switch indexPath.row {
////        case 1:
////            return CGSize(width: 200, height: 200)
////        default:
////            return CGSize(width: 50, height: 50)
////        }
//
//        return CGSize(width: 60, height: 70)
//    }
}
