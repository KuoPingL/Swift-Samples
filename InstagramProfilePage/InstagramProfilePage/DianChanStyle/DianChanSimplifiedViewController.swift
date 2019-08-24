//
//  DianChanSimplifiedViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/24.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DianChanSimplifiedViewController: UIViewController, UIScrollViewDelegate {
    
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
        let vc = DianChanSimplifiedCollectionsController()
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
        v.delegate = self
        v.showsVerticalScrollIndicator = false
        v.contentInsetAdjustmentBehavior = .never
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
    private lazy var collectionViewController: DianChanSimplifiedCollectionsController = {
        let v = DianChanSimplifiedCollectionsController()
        v.collectionView.isScrollEnabled = false
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
    
    //MARK: 旋轉螢幕後的重設
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        profileContainerView.frame.size.width = view.frame.width
        collectionViewController.view.frame = collectionContainerView.bounds
        view.layoutIfNeeded()
    }
    
    // 重新計算正確位置與 Size
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileContainerView.frame.size.height = profileViewController.view.frame.height
        collectionContainerViewBottomAnchor.constant = -view.safeAreaInsets.top
        collectionViewController.view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: containerView.frame.height)
        gradientLayer.frame = containerView.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupProfileContainerView()
        setupProfileViewController()
        setupCollectionContainerView()
        setupCollectionViewControllers()
        // 設定 GradientLayer
        DispatchQueue.main.async {
            self.gradientLayer.colors = [UIColor.purple.cgColor, UIColor.black.cgColor]
            self.gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            self.gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            self.gradientLayer.frame = self.containerView.bounds
            self.containerView.layer.insertSublayer(self.gradientLayer, at: 0)
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        view.addConstraints([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        scrollView.addSubview(containerView)
        scrollView.addConstraints([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        let containerHeightConstraint = containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        containerHeightConstraint.priority = .defaultLow
        containerHeightConstraint.isActive = true
    }
    
    private func setupProfileViewController() {
        addChildViewController(profileViewController)
        profileContainerView.addSubview(profileViewController.view)
        profileViewController.didMove(toParentViewController: self)
        profileViewController.view.translatesAutoresizingMaskIntoConstraints = false
        profileContainerView.addConstraints([
            profileViewController.view.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor),
            profileViewController.view.widthAnchor.constraint(equalTo: profileContainerView.widthAnchor, multiplier: 1.0),
            profileViewController.view.topAnchor.constraint(equalTo: profileContainerView.topAnchor, constant: 0),
            profileViewController.view.heightAnchor.constraint(equalTo: profileContainerView.heightAnchor, multiplier: 1.0)
            ])
        profileViewController.view.layoutIfNeeded()
    }
    
    private func setupProfileContainerView() {
        containerView.addSubview(profileContainerView)
        containerView.addConstraints([
            containerView.bottomAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: UIScreen.main.bounds.height),
            profileContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            profileContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            profileContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupCollectionContainerView() {
        containerView.addSubview(collectionContainerView)
        containerView.addConstraints([
            collectionContainerView.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor),
            collectionContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            collectionContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
            ])
        
        collectionContainerViewBottomAnchor.isActive = true
    }
    
    private func setupCollectionViewControllers() {
        self.addChildViewController(collectionViewController)
        collectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        collectionContainerView.addSubview(collectionViewController.view)
        collectionViewController.didMove(toParentViewController: self)
        
        collectionContainerView.addConstraints([
            collectionViewController.view.topAnchor.constraint(equalTo: collectionContainerView.topAnchor),
            collectionViewController.view.centerXAnchor.constraint(equalTo: collectionContainerView.centerXAnchor),
            collectionViewController.view.widthAnchor.constraint(equalTo: collectionContainerView.widthAnchor, multiplier: 1.0),
            collectionViewController.view.bottomAnchor.constraint(equalTo: collectionContainerView.bottomAnchor)
            ])
        
        collectionViewController.view.layoutIfNeeded()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.setContentOffset(CGPoint.zero, animated: false)
        } else if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.frame.size.height), animated: false)
        }
    }
}
