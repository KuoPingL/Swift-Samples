//
//  DianChanImprovedViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit

class DianChanImprovedViewController: UIViewController, UIScrollViewDelegate, DianChanImprovedCollectionsControllerDelegate {
    
    private lazy var settingBarButtonItem: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(settingPressed(_:)))
        return b
    }()
    
    @objc private func settingPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var emailBarButtonItem: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(emailPressed(_:)))
        return b
    }()
    
    @objc private func emailPressed(_ sender: UIBarButtonItem) {
        let vc = DianChanCollectionsController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private lazy var pointBarButtonItem: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(pointPressed(_:)))
        return b
    }()
    
    @objc private func pointPressed(_ sender: UIBarButtonItem) {
        let vc = BlankViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadView() {
        super.loadView()
        title = "About Me"
        navigationItem.leftBarButtonItems = [settingBarButtonItem, emailBarButtonItem]
        navigationItem.rightBarButtonItem = pointBarButtonItem
    }
    
    //MARK:- 設定 Layout
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: view.bounds)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsVerticalScrollIndicator = false
        v.contentInsetAdjustmentBehavior = .never
        v.isScrollEnabled = false
        return v
    }()
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    private lazy var profileViewController = DianChanUserProfileController()
    
    private lazy var profileContainerView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        return v
    }()
    
    // MARK: 最下面 CollectionView 的 Controller 與 它的 ContainerView
    private lazy var collectionViewController: DianChanImprovedCollectionsController = {
        let v = DianChanImprovedCollectionsController()
        v.delegate = self
        return v
    }()
    
    private lazy var collectionContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var collectionContainerViewBottomAnchor: NSLayoutConstraint = {
        return collectionContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -view.safeAreaInsets.top)
    }()
    //MARK: 執行 DianChanCollectionsControllerDelegate
    
    func collectionViewDidReachTop(in viewController: UIViewController?, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    
    
}
