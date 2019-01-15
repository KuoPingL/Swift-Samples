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
    func collectionViewDidReachTop(in viewController: UIViewController?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

protocol DianChanDummyCollectionViewControllerProtocol: NSObjectProtocol {
    func collectionViewAllowScrolling(_ scrollView: UIScrollView?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

class DianChanDummyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum Types {
        case advertice
        case photo
    }
    
    // 通知 DianChanCollectionsController CollectionView 被 Scroll 的行為
    weak var delegate: DianChanDummyCollectionViewControllerDelegate? {
        didSet {
            if delegate != nil {
                collectionView?.isScrollEnabled = false
            }
        }
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
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // 當 CollectionView 托拉完成時，如果最後的位置是最頂部 targetContentOffset.pointee.y <= 0
        // 而且 Delegate 有設定的話，那就將 CollectionView 的 ContentOffset.y 設為 0 並停止 isScrollEnable.
        // 最後就回傳給 Delegate 知道
        if targetContentOffset.pointee.y <= 0 {
            guard let delegate = delegate else {
                return
            }
            scrollView.contentOffset.y = 0
            scrollView.isScrollEnabled = false
            // DianChanDummyCollectionViewController -通知-> DianChanCollectionsController -通知-> DianChanViewController 
            delegate.collectionViewDidReachTop(in: self, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 跟 scrollViewWillEndDragging 差不多
        if scrollView == collectionView {
            guard let delegate = delegate else {
                // normal action
                return
            }
            
            if scrollView.contentOffset.y <= 0 {
                scrollView.contentOffset.y = 0
                if collectionViewShouldDisableScrolling {
                    weak var vc = self
                    var pointer = CGPoint.zero
                    delegate.collectionViewDidReachTop(in: vc, withVelocity: .zero, targetContentOffset: withUnsafeMutablePointer(to: &pointer, {
                        $0
                    }))
                } else {
                    collectionViewShouldDisableScrolling = true
                }
            }
        }
    }
    
    // 為了要讓 collectionView?.setContentOffset 後不會被 scrollViewDidScroll 那邊設為 isScrollEnable = false 所以用 collectionViewShouldDisableScrolling: Bool 來做 flag
    // 如此一來，CollectionView 用這 Code 轉到上面時，也不會被停止 Scorlling.
    private var collectionViewShouldDisableScrolling = true
    func collectionViewScrollToTop() {
        collectionViewShouldDisableScrolling = false
        collectionView?.setContentOffset(.zero, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 這邊你可能要跟 Delegate 說選擇了某個 Cell
        print("SELECTED : \(indexPath)")
    }
}

extension DianChanDummyCollectionViewController: DianChanDummyCollectionViewControllerProtocol {
    
    // 這是由 Parent 來告知 CollectionView 可以 Scroll 了
    // DianChanViewController -通知-> DianChanCollectionsController -通知-> DianChanDummyCollectionViewController
    func collectionViewAllowScrolling(_ scrollView: UIScrollView?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        collectionView?.isScrollEnabled = true
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
