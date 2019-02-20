//
//  ShapeTransformController.swift
//  AnimationDemo
//
//  Created by Jimmy on 2018/10/29.
//  Copyright © 2018 Jimmy. All rights reserved.
//

import UIKit

class ShapeTransformController: UIViewController {
    private let oscilloscopeView: OscilloScreen = {
        let v = OscilloScreen()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalTo: v.widthAnchor, multiplier: 1 / OscilloScreen.widthToHeightRatio).isActive = true
        return v
    }()
    
    private let threeDimensionView: ThreeDimensionMatrixView = {
        let v = ThreeDimensionMatrixView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let oscilloControlView: OscilloControlView = {
        let v = OscilloControlView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var rightButton: UIButton = {
        let b = UIButton()
        b.setTitle("Func", for: .normal)
        b.addTarget(self, action: #selector(rightButtonItemPressed), for: .touchUpInside)
        b.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 40))
        b.setTitleColor(UIColor.blue, for: .normal)
        return b
    }()
    
    private lazy var rightButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Func", style: .done, target: self, action: #selector(rightButtonItemPressed))
    }()
    
    private let popupVC = FuncPopUpController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(oscilloscopeView)
        view.addSubview(threeDimensionView)
        view.addSubview(oscilloControlView)
        
        threeDimensionView.delegate = oscilloscopeView
        
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        view.addConstraints([
            oscilloscopeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40 + navigationBarHeight),
            oscilloscopeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oscilloscopeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        
        view.addConstraints([
            threeDimensionView.topAnchor.constraint(equalTo: oscilloscopeView.bottomAnchor, constant: 40),
            threeDimensionView.heightAnchor.constraint(equalTo: threeDimensionView.widthAnchor, multiplier: 0.5),
            threeDimensionView.leadingAnchor.constraint(equalTo: oscilloscopeView.leadingAnchor),
            threeDimensionView.trailingAnchor.constraint(equalTo: oscilloscopeView.trailingAnchor)
            ])
        
        view.addConstraints([
            oscilloControlView.topAnchor.constraint(equalTo: threeDimensionView.bottomAnchor, constant: 20),
            oscilloControlView.leadingAnchor.constraint(equalTo: oscilloscopeView.leadingAnchor),
            oscilloControlView.trailingAnchor.constraint(equalTo: oscilloscopeView.trailingAnchor),
            oscilloControlView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
        
        DispatchQueue.main.async {
            self.oscilloscopeView.addSquare()
        }
        
        // Setup NavigationButtonItem
//        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc private func rightButtonItemPressed() {
        popupVC.delegate = self
        popupVC.preferredContentSize = CGSize(width: view.bounds.width/2.0, height: view.bounds.height / 3.0)
        popupVC.modalPresentationStyle = .popover
        popupVC.popoverPresentationController?.barButtonItem = rightButtonItem
        popupVC.popoverPresentationController?.permittedArrowDirections = [.up]
        popupVC.popoverPresentationController?.delegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    
}

extension ShapeTransformController: FuncPopUpControllerDelegate {
    func didSelect(_ function: FuncPopUpControllerFunctions) {
        switch function {
        case .none:
            return
        case .rotate30:
            let transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(30.0/180.0 * Double.pi), 0, 0, 1)
            applyTransform(transform)
        }
    }
    
    func reset() {
        applyTransform(CATransform3DIdentity)
    }
    
    private func applyTransform(_ transform: CATransform3D) {
        oscilloscopeView.applyTransformation(transform)
        threeDimensionView.applyTransform(transform)
        popupVC.dismiss(animated: true, completion: nil)
    }
}

extension ShapeTransformController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

enum FuncPopUpControllerFunctions: String {
    case none = "Not Yet Implemented"
    case rotate30 = "Rotate 30 Degree"
    
    static func rawValues() -> [String] {
        return
            [
                FuncPopUpControllerFunctions.none.rawValue,
                FuncPopUpControllerFunctions.rotate30.rawValue
        ]
    }
}

protocol FuncPopUpControllerDelegate: class {
    func didSelect(_ function: FuncPopUpControllerFunctions)
    func reset()
}

class FuncPopUpController: UIViewController{
    
    var delegate: FuncPopUpControllerDelegate?
    
    private enum Constants {
        static let cellId = "cellID"
    }
    
    private let functions = FuncPopUpControllerFunctions.rawValues()
    private let resetButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Reset", for: .normal)
        b.setTitleColor(.red, for: .normal)
        b.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return b
    }()
    private let tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        
        view.addSubview(resetButton)
        view.addSubview(tableView)
        
        view.addConstraints([
            resetButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.cellId)
        tableView.tableFooterView = UIView()
        
        resetButton.addTarget(self
            , action: #selector(resetButtonPressed),
              for: .touchUpInside)
    }
    
    @objc private func resetButtonPressed() {
        delegate?.reset()
    }
}

extension FuncPopUpController: UITableViewDelegate, UITableViewDataSource {
    // DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    // DELEGATE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let function = FuncPopUpControllerFunctions(rawValue: functions[indexPath.row]) {
            delegate?.didSelect(function)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath)
        cell.textLabel?.text = functions[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
