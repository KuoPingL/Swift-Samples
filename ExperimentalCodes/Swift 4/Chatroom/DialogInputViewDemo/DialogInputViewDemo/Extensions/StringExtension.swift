//
//  StringExtension.swift
//  DialogInputViewDemo
//
//  Created by Jimmy on 2019/8/25.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, tableName: nil, bundle: .main, value: "", comment: "")
        }
    }
}
