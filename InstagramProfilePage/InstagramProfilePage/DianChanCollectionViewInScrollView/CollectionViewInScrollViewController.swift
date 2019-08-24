//
//  CollectionViewInScrollViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/22.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class CollectionViewInScrollViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: view.bounds)
        return sv
    }()
    
    private lazy var collectionViewA: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        let cv = UICollectionView(frame: CGRect(origin: .zero, size: self.view.frame.size), collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var collectionViewB: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        let cv = UICollectionView(frame: CGRect(origin: CGPoint(x: self.view.frame.width, y: 0), size: self.view.frame.size), collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(collectionViewA)
        
        scrollView.addSubview(collectionViewB)
        
        scrollView.contentSize = CGSize(width: collectionViewA.frame.width + collectionViewB.frame.width, height: collectionViewA.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if collectionView == collectionViewA {
            cell.backgroundColor = .blue
        } else {
            cell.backgroundColor = .red
        }
        
        return cell
    }
    
}

