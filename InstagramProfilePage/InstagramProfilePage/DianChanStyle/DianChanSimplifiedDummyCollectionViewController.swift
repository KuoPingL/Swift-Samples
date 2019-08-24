//
//  DianChanSimplifiedDummyCollectionViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DianChanSimplifiedDummyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum Types {
        case advertice
        case photo
    }
    
    private let type: Types
    private let cellID = "cellId"
    
    // 選擇 CollectionView 的類型
    init(_ type: Types) {
        self.type = type
        super.init(collectionViewLayout: .init())
        // 給相對的 Flowlayout
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView?.collectionViewLayout = flowlayout
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type {
        case .advertice:
            collectionView?.backgroundColor = .green
        case .photo:
            collectionView?.backgroundColor = .white
        }
        collectionView?.alwaysBounceVertical = true
        
        // 這裡可以依 Type 的不同 Register 不同的 UICollectionViewCell
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        DispatchQueue.main.async {
            if let flowlayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout, let collectionView = self.collectionView {
                let minimumInteritemSpacing = (flowlayout.minimumInteritemSpacing / UIScreen.main.bounds.width) * collectionView.frame.width
                flowlayout.minimumInteritemSpacing = minimumInteritemSpacing
                self.collectionView?.collectionViewLayout = flowlayout
                self.collectionView?.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 回傳你 data.count
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            // 因為我一定會有 Flowlayout 所以只要無法轉為 UICollectionFlowLayout 的直接回傳 CGSize.zero
            return size
        }
        
        // 依照不同的 Type 給相對的 Size
        switch type {
        case .advertice:
            size = CGSize(width: view.frame.width - 20, height: 100)
        case .photo:
            size = CGSize(width: view.frame.width / 3.0 - flowlayout.minimumInteritemSpacing * 3.0, height: view.frame.width / 3.0 - flowlayout.minimumInteritemSpacing * 3.0)
        }
        return size
    }
    
}
