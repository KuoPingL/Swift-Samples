//
//  BlankViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/11.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class BlankViewController: UIViewController {
    private lazy var collectionViewController: DianChanCollectionsController = {
        let v = DianChanCollectionsController()
        var pointer = CGPoint(x: 0, y: 0)
        v.collectionViewAllowScrolling(nil, withVelocity: .zero, targetContentOffset: withUnsafeMutablePointer(to: &pointer, {
            $0
        }))
        return v
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        collectionViewController.view.frame.size.height = view.frame.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
        collectionViewController.view.frame.size.height = view.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .blue
        
        addChildViewController(collectionViewController)
        collectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionViewController.view)
        view.addConstraints([
            collectionViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
        collectionViewController.didMove(toParentViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(collectionViewController.view.frame)
        print(view.frame)
        print(#function)
    }
    
}
