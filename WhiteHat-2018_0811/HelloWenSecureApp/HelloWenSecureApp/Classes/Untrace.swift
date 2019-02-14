//
//  Untrace.swift
//  HelloWenSecureApp
//
//  Created by Jimmy on 2018/8/18.
//  Copyright © 2018年 Demo. All rights reserved.
//

import Foundation
// 若有人有心解開這 Code，只要在所有 code 前 return 即可。
// 那麼，該如何呢？ 1. call 很多次 2. inline(__always) 但會很肥 因為每當你呼叫就會直接黏上一個 Code。
// inline 也能增加空間，加強 efficiency。(要多暸解)

@inline(__always) func disableTrace() {
    
    #if !DEBUG
    let disableAttach: CInt = 31 // 要查查為何 31
    // https://blog.csdn.net/edonlii/article/details/8717029
    // 呼叫 c 語言的 library ptrace 並強制 ptrace 停止
    // ndk 可以通用 android 與 ios
    let handle = dlopen("/usr/lib/libc.dylib", RTLD_NOW)
    let sym = dlsym(handle, "ptrace")
    
    // https://swift.gg/2016/05/18/swift-qa-2016-05-18/
    // CInt == Int32
    // 使用這段轉型，方便呼叫 ptrace
    typealias PtraceType = @convention(c)(CInt, pid_t, CInt, CInt) -> CInt
    
    // 傳入後就會停止 trace 功能
    let ptrace = unsafeBitCast(sym, to: PtraceType.self)
    _ = ptrace(disableAttach, 0, 0, 0)
    
    dlclose(handle)
    #endif
}
