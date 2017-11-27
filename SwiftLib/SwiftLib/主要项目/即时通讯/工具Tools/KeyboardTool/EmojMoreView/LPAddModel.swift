//
//  LPAddModel.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/20.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
@objcMembers
class LPAddModel: NSObject {
    var image: String?
    var name: String?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        printLog(value)
    }
}
