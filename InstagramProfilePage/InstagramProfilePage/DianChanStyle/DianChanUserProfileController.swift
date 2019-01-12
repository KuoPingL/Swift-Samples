//
//  DianChanUserProfileController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/10.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class DianChanUserProfileController: UIViewController {
    let ratio: CGFloat = 0.3
    private let imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.purple
        return v
    }()
    
    private lazy var iconImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = UIScreen.main.bounds.size.width * ratio / 2.0
        v.clipsToBounds = true
        v.backgroundColor = .orange
        return v
    }()
    
    private let userNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .clear
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 15)
        l.setContentHuggingPriority(UILayoutPriority.init(999), for: .vertical)
        l.text = "User Name"
        return l
    }()
    
    private let userIDLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .clear
        l.textColor = .lightText
        l.font = UIFont.systemFont(ofSize: 10)
        l.setContentHuggingPriority(UILayoutPriority.init(999), for: .vertical)
        l.text = "218483929292"
        return l
    }()
    
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .clear
        l.textColor = .white
        l.numberOfLines = 0
        l.setContentHuggingPriority(UILayoutPriority.init(999), for: .vertical)
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "無論事情變得多糟糕，錯誤會幫我們認清一些事物墮我們真正該做的事情。"
        return l
    }()
    
    private lazy var userStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [userNameLabel, userIDLabel, descriptionLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.alignment = UIStackViewAlignment.leading
        v.spacing = 2
        v.distribution = UIStackView.Distribution.fill
        return v
    }()
    
    private let fansCounterLabel: UILabel = {
        let l = UILabel()
        let counterText = NSMutableAttributedString(string: "367", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.white.cgColor])
        let fansText = NSAttributedString(string: " 粉絲數", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightText.cgColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        counterText.append(fansText)
        l.textAlignment = .center
        l.attributedText = counterText
        return l
    }()
    
    private let followersCounterLabel: UILabel = {
        let l = UILabel()
        let counterText = NSMutableAttributedString(string: "123", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.white.cgColor])
        let followersText = NSAttributedString(string: " 追蹤數", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightText.cgColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        counterText.append(followersText)
        l.textAlignment = .center
        l.attributedText = counterText
        return l
    }()
    
    private let personalGainTextField: UITextField = {
        let t = UITextField()
        t.text = "個人收益"
        t.textColor = .white
        t.leftViewMode = .always
        let v = UIImageView()
        v.backgroundColor = .orange
        t.leftView = v
        t.font = UIFont.systemFont(ofSize: 12)
        t.textAlignment = .center
        t.isUserInteractionEnabled = false
        return t
    }()
    
    private let oneSmallView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightText
        return v
    }()
    
    private let secondSmallView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightText
        return v
    }()
    
    private lazy var counterStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [fansCounterLabel, followersCounterLabel, personalGainTextField])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alignment = .center
        v.axis = .horizontal
        v.distribution = .fillEqually
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(imageView)
        view.addSubview(iconImageView)
        view.addSubview(userStackView)
        view.addSubview(counterStackView)
        view.addSubview(oneSmallView)
        view.addSubview(secondSmallView)
        
        view.addConstraints([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height * 0.3),
            iconImageView.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, constant: 0),
            iconImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * ratio),
            userStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            userStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            userStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userStackView.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            counterStackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            counterStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            counterStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            oneSmallView.topAnchor.constraint(equalTo: counterStackView.topAnchor),
            oneSmallView.centerXAnchor.constraint(equalTo: fansCounterLabel.trailingAnchor),
            oneSmallView.widthAnchor.constraint(equalToConstant: 2),
            oneSmallView.heightAnchor.constraint(equalTo: counterStackView.heightAnchor),
            secondSmallView.topAnchor.constraint(equalTo: counterStackView.topAnchor),
            secondSmallView.centerXAnchor.constraint(equalTo: followersCounterLabel.trailingAnchor),
            secondSmallView.widthAnchor.constraint(equalToConstant: 2),
            secondSmallView.heightAnchor.constraint(equalTo: counterStackView.heightAnchor),
            ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame.size.height = counterStackView.frame.maxY + 10
    }
}
