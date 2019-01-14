//
//  DianChanCollectionsController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

protocol DianChanCollectionsControllerDelegate: NSObjectProtocol {
    func collectionViewDidReachTop(in viewController: UIViewController, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

protocol DianChanCollectionsControllerProtocol: NSObjectProtocol {
    func collectionViewAllowScrolling(_ scrollView: UIScrollView?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

class DianChanCollectionsController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, DianChanDummyCollectionViewControllerDelegate  {
    
    weak var delegate: DianChanCollectionsControllerDelegate?
    
    private let cellID = "cellId"
    
    private lazy var leftButton: UIButton = {
        let b = UIButton()
        b.setTitle("Left Button", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(leftButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    @objc private func leftButtonPressed(_ sender: UIButton) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
    }
    
    private lazy var rightButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Right Button", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.addTarget(self, action: #selector(rightButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    @objc private func rightButtonPressed(_ sender: UIButton) {
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
    
    private let slider: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 2.5
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: .init())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        v.dataSource = self
        v.isPagingEnabled = true
        return v
    }()
    
    private lazy var sliderLeading: NSLayoutConstraint = {
        return slider.leadingAnchor.constraint(equalTo: leftButton.leadingAnchor)
    }()
    
    private lazy var controllers: [UIViewController] = {
        return [DianChanDummyCollectionViewController(.photo), DianChanDummyCollectionViewController(.advertice)]
    }()
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(slider)
        view.addSubview(collectionView)
        
        view.addConstraints([
            leftButton.topAnchor.constraint(equalTo: rightButton.topAnchor),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftButton.widthAnchor.constraint(equalTo: rightButton.widthAnchor),
            leftButton.heightAnchor.constraint(equalTo: rightButton.heightAnchor),
            leftButton.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            
            rightButton.topAnchor.constraint(equalTo: view.topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightButton.heightAnchor.constraint(equalToConstant: 30),
            
            slider.widthAnchor.constraint(equalTo: rightButton.widthAnchor, multiplier: 1.0),
            slider.heightAnchor.constraint(equalToConstant: 5),
            slider.topAnchor.constraint(equalTo: leftButton.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: slider.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        sliderLeading.isActive = true
        
        collectionView.register(DianChanCell.self, forCellWithReuseIdentifier: cellID)
        
        let flowout = UICollectionViewFlowLayout()
        flowout.scrollDirection = .horizontal
        flowout.minimumLineSpacing = 0
        flowout.sectionInset = .zero
        collectionView.collectionViewLayout = flowout
        
        _ = controllers.map {
            self.addChildViewController($0)
            $0.didMove(toParentViewController: self)
            let v = $0 as? DianChanDummyCollectionViewController
            if self.delegate != nil {
                v?.delegate = self
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DianChanCollectionsController DidAppear CV : \(collectionView.frame)")
        print("DianChanCollectionsController DidAppear View : \(view.frame)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DianChanCell
        
        if cell == nil {
            cell = DianChanCell()
        }
        let vc = controllers[indexPath.row]
        
        cell?.attachHostView(vc.view)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        print("CELL SIZE : \(size)")
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let contentOffsetX = scrollView.contentOffset.x
            let leadingDistance = (contentOffsetX / collectionView.frame.width) * leftButton.frame.width
            UIViewPropertyAnimator.init(duration: 0, curve: .easeInOut) {
                self.sliderLeading.constant = leadingDistance
                }.startAnimation()
        }
    }
    
    func collectionViewDidReachTop(in viewController: UIViewController, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let delegate = delegate else {
            return
        }
        delegate.collectionViewDidReachTop(in: viewController, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}

extension DianChanCollectionsController: DianChanCollectionsControllerProtocol {
    func collectionViewAllowScrolling(_ scrollView: UIScrollView?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        _ = controllers.map {
            let v = $0 as? DianChanDummyCollectionViewController
            v?.collectionViewAllowScrolling(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
}
