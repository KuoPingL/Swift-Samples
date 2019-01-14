//
//  DianChanDummyCollectionViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol DianChanDummyCollectionViewControllerDelegate: NSObjectProtocol {
    func collectionViewDidReachTop(in viewController: UIViewController, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

protocol DianChanDummyCollectionViewControllerProtocol: NSObjectProtocol {
    func collectionViewAllowScrolling(_ scrollView: UIScrollView?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

class DianChanDummyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum Types {
        case advertice
        case photo
    }
    
    weak var delegate: DianChanDummyCollectionViewControllerDelegate?
    
    private let type: Types
    private let cellID = "cellId"
    
    init(_ type: Types) {
        self.type = type
        super.init(collectionViewLayout: .init())
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView?.collectionViewLayout = flowlayout
        if delegate != nil {
            collectionView?.isScrollEnabled = false
        }
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
            return size
        }
        
        switch type {
        case .advertice:
            size = CGSize(width: view.frame.width - 20, height: 100)
        case .photo:
            size = CGSize(width: view.frame.width / 3.0 - flowlayout.minimumInteritemSpacing * 3.0, height: view.frame.width / 3.0 - flowlayout.minimumInteritemSpacing * 3.0)
        }
        return size
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if targetContentOffset.pointee.y <= 0 {
            guard let delegate = delegate else {
                return
            }
            scrollView.contentOffset.y = 0
//            scrollView.isScrollEnabled = false
            delegate.collectionViewDidReachTop(in: self, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            guard let delegate = delegate else {
                // normal action
                return
            }
            
//            if scrollView.contentOffset.y <= 0 {
//                scrollView.contentOffset.y = 0
//            }
        }
    }
}

extension DianChanDummyCollectionViewController: DianChanDummyCollectionViewControllerProtocol {
    
    func collectionViewAllowScrolling(_ scrollView: UIScrollView?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        collectionView?.isScrollEnabled = true
//        print("targetContentOffset : \(targetContentOffset.pointee)")
//        print("velocity : \(velocity)")
//        if velocity.y > 0, let scrollView = scrollView {
//            scrollViewWillEndDragging(self.collectionView! , withVelocity: velocity, targetContentOffset: targetContentOffset)
////            let contentOffsetY = scrollView.contentOffset.y
////            let targetOffsetY = targetContentOffset.pointee.y
////            let duration: TimeInterval = TimeInterval(velocity.y / (targetOffsetY - contentOffsetY)) * 10
////            print("Duration : \(duration)")
////            let timeParameters = UISpringTimingParameters(dampingRatio: 1.0, initialVelocity: CGVector(dx: velocity.x, dy: velocity.y))
////            let animation = UIViewPropertyAnimator(duration: 1, timingParameters: timeParameters)
////            animation.addAnimations {
////                self.collectionView?.contentOffset = CGPoint(x: 0, y: 200)
////            }
////            animation.startAnimation()
//        } else if scrollView == nil {
//            self.scrollViewWillEndDragging(self.collectionView!, withVelocity: velocity, targetContentOffset: targetContentOffset)
//        }
    }
}
