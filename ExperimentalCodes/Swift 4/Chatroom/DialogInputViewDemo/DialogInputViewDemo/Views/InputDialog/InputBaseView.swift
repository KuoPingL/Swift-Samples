//
//  InputBaseView.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/31.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class InputBaseView: UIView {
    func prepareUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)
        
        blurView.edgeTo(self, with: .zero)
    }
}
