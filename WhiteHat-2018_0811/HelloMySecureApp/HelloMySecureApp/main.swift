//
//  main.swift
//  HelloMySecureApp
//
//  Created by Jimmy on 2018/8/12.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
import UIKit

// http://wiki.softarts.cc/doku.php?id=%E5%85%AC%E9%96%8B%3A20180811_tibame_ios_app%E8%B3%87%E8%A8%8A%E5%AE%89%E5%85%A8
_ = autoreleasepool {
    // 終止 Trace // 跑的時候，注意上方 Build and Run (|>) 按鈕，啟動時就會停止。 但請先將 DisableTrace.swift 中的 #if !DEBUG 和 #endif 去掉。
    disableTrace()
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(
                to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc)),
        nil,
        NSStringFromClass(AppDelegate.self) //Or your class name // 與 APPDelegate 搭配
    )
    
}
