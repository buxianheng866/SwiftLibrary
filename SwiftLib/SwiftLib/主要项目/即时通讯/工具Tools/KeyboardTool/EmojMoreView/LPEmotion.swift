//
//  LPEmotion.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
@objcMembers
class LPEmotion: NSObject {
    
    var face_name = ""// 表情对应的文字
    var code = ""     // 16进制
    
    var isRemove: Bool = false //删除按钮
    var isEmpty: Bool = false  //占位
    
    init(empty: Bool) {
        isEmpty = empty
    }
    
    init(remove: Bool) {
        isRemove = remove
    }
    
    init(dict: [String : String]) {
        super.init()
        setValuesForKeys(dict)
        if !code.isEmpty {
            code = BarHelper.emojInCode(code: code)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
