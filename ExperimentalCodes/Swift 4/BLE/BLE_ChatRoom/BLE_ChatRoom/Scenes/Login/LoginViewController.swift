//
//  LoginViewController.swift
//  BLE_ChatRoom
//
//  Created by Jimmy on 2019/7/27.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    public var user: UserModel = UserModel()
    
    public var isLoginPage: Bool = true
    
    private lazy var avatarImageView: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.translatesAutoresizingMaskIntoConstraints = false
        i.backgroundColor = .white
        i.layer.cornerRadius = view.frame.width * 0.5 * 0.5
        i.layer.masksToBounds = true
        i.layer.borderWidth = 2.0
        i.layer.borderColor = UIColor.black.cgColor
        return i
    }()
    
    private var avatorsViewController = AvatarsViewController()
    
    private lazy var chooseAvatarButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.numberOfLines = 0
        b.backgroundColor = .clear
        b.layer.cornerRadius = view.frame.width * 0.5 * 0.5
        b.setTitle(isLoginPage ? "_choose_avatar".localized : "", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(chooseAvatarButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    var avatorViewControllerHeight: CGFloat {
        get {
            return view.frame.height / 3.0
        }
    }
    @objc func chooseAvatarButtonPressed(_ sender: UIButton) {
        loginTextField.resignFirstResponder()
        attachAvatorViewController()
    }
    
    private lazy var loginTextField: UITextField = {
        let v = UITextField(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.borderStyle = UITextField.BorderStyle.bezel
        v.contentMode = .center
        v.clearButtonMode = UITextField.ViewMode.whileEditing
        v.textAlignment = .center
        v.placeholder = "_enter_your_name".localized
        v.addTarget(self, action: #selector(textFieldBecomeFirstResponder), for: .touchDown)
        return v
    }()
    
    @objc private func textFieldBecomeFirstResponder() {
        dismissAvatorViewController()
    }
    
    private var loginTextFieldDelegate: LoginTextFieldDelegate?
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.setTitle(isLoginPage ? "_login".localized : "_save".localized, for: .normal)
        b.layer.cornerRadius = 10.0
        b.layer.masksToBounds = true
        b.titleEdgeInsets = UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5)
        b.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        b.backgroundColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        loginTextField.resignFirstResponder()
        // Login
        user.name = loginTextField.text ?? ""
        if user.isDataComplete {
            user.save()
            if isLoginPage {
                let chatRoomViewController = ChatRoomViewController()
                let nvc = UINavigationController(rootViewController: chatRoomViewController)
                present(nvc, animated: true, completion: nil)
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private lazy var colorPickerButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor.black.cgColor
        b.backgroundColor = .black
        b.setTitleColor(.white, for: .normal)
        b.setTitle("_login_color_picker".localized, for: .normal)
        b.addTarget(self, action: #selector(colorPickerButtonPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    private lazy var colorPickerController: ColorPickerViewController = {
        let c = ColorPickerViewController()
        c.delegate = self
        c.modalPresentationStyle = .overCurrentContext
        c.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        return c
    }()
    
    @objc func colorPickerButtonPressed(_ sender: UIButton) {
        loginTextField.resignFirstResponder()
        dismissAvatorViewController()
        colorPickerController.selectedColor = user.color
        colorPickerController.view.layoutIfNeeded()
        present(colorPickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if user.isDataComplete {
            loginTextField.text = user.name
            view.backgroundColor = user.color
            avatarImageView.image = user.avatar
            chooseAvatarButton.setTitle(nil, for: .normal)
        }
    }
    
    private func setupUI() {
        loginTextFieldDelegate = LoginTextFieldDelegate(textField: loginTextField)
        view.addSubview(avatarImageView)
        view.addSubview(chooseAvatarButton)
        view.addSubview(loginTextField)
        view.addSubview(loginButton)
        view.addSubview(colorPickerButton)
        let topConstant: CGFloat = navigationController == nil ? 40 : navigationController!.navigationBar.frame.height
        print(topConstant)
        view.addConstraints([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1.0),
            
            chooseAvatarButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            chooseAvatarButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            chooseAvatarButton.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            chooseAvatarButton.heightAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1.0),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            colorPickerButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            colorPickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        view.backgroundColor = user.color
    }
    
    @objc private func attachAvatorViewController() {
        if let avatorsParent = avatorsViewController.parent, avatorsParent == self {
            return
        }
        
        avatorsViewController.avators = UIImage.Avatars.all()
        avatorsViewController.delegate = self
        addChild(avatorsViewController)
        
        avatorsViewController.view.frame = CGRect(x: view.frame.width, y: self.view.frame.height - avatorViewControllerHeight, width: view.frame.width, height: avatorViewControllerHeight)
        view.addSubview(avatorsViewController.view)
        avatorsViewController.didMove(toParent: self)
        
        UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.avatorsViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - self.avatorViewControllerHeight, width: self.view.frame.width, height: self.avatorViewControllerHeight)
            self.loginButton.isHidden = true
            }.startAnimation()
    }
    
    private func dismissAvatorViewController() {
        if avatorsViewController.parent == nil {
            return
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
            self.avatorsViewController.view.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height - self.avatorViewControllerHeight, width: self.view.frame.width, height: self.avatorViewControllerHeight)
            self.loginButton.isHidden = false
        }
        animator.addCompletion { (animatingPosition) in
            self.avatorsViewController.view.removeFromSuperview()
            self.avatorsViewController.willMove(toParent: nil)
            self.avatorsViewController.removeFromParent()
            self.avatorsViewController.didMove(toParent: nil)
        }
        
        animator.startAnimation()
    }
}


extension LoginViewController: ColorPickerDelegate {
    func didSelect(color: UIColor) {
        view.backgroundColor = color
        user.color = color
    }
}


extension LoginViewController: AvatarsViewControllerDelegate {
    func didSelect(avator: UIImage.Avatars) {
        user.avatarType = avator
        avatarImageView.image = user.avatar
        chooseAvatarButton.setTitle(nil, for: .normal)
    }
    
    func didPressedDoneButton() {
        dismissAvatorViewController()
    }
}
