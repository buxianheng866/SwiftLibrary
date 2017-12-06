//
//  IMManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

/**
 bxh001 11111 仗剑天下
 bxh002 11111 把酒问青天
 */

class IMManager: NSObject {
    static let `default`: IMManager = {
        let im = IMManager()
        NIMSDK.shared().loginManager.add(im as NIMLoginManagerDelegate)
        return im
    }()
    
    /** 初始化SDK*/
    class func IMint() -> Void {
        NIMSDK.shared().register(withAppID: IMappKey, cerName: nil)
    }
    
}
