
//
//  DianChanSimplifiedCollectionsController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DianChanSimplifiedCollectionsController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
    
    private lazy var centerButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Center Button", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .black
        b.addTarget(self, action: #selector(centerButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    @objc private func centerButtonPressed(_ sender: UIButton) {
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
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
        collectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .right, animated: true)
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
        let c1 = DianChanSimplifiedDummyCollectionViewController(.photo)
        c1.collectionView?.isScrollEnabled = false
        let c2 = DianChanSimplifiedDummyCollectionViewController(.advertice)
        c2.collectionView?.isScrollEnabled = false
        let c3 = DianChanSimplifiedDummyCollectionViewController(.photo)
        c3.collectionView?.isScrollEnabled = false
        return [c1, c2, c3]
    }()
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(leftButton)
        view.addSubview(centerButton)
        view.addSubview(rightButton)
        view.addSubview(slider)
        view.addSubview(collectionView)
        
        view.addConstraints([
            leftButton.topAnchor.constraint(equalTo: rightButton.topAnchor),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftButton.widthAnchor.constraint(equalTo: rightButton.widthAnchor),
            leftButton.heightAnchor.constraint(equalTo: rightButton.heightAnchor),
            leftButton.trailingAnchor.constraint(equalTo: centerButton.leadingAnchor),
            
            centerButton.topAnchor.constraint(equalTo: rightButton.topAnchor),
            centerButton.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            centerButton.widthAnchor.constraint(equalTo: rightButton.widthAnchor),
            centerButton.heightAnchor.constraint(equalTo: rightButton.heightAnchor),
            
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        return 3
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
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let controller = controllers[indexPath.row] as? DianChanDummyCollectionViewController {
            //MARK: 這裡可以將你要的 Models 帶入 controller
            controller.collectionViewScrollToTop()
        }
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
}
