//
//  IMCommon.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

let IMappKey = "1ef7df2005fac46151002a415582e158"
let IMappSecret = "9d847024784d"


// 表情键盘颜色大全
let kChatBoxColor = normalRGBA(r: 244.0, g: 244.0, b: 246.0, a: 1.0)
let kLineGrayColor = normalRGBA(r: 188.0, g: 188.0, b: 188.0, a: 0.6)

// 键盘尺寸
let kChatKeyboardBgColor = RGBA(r: 0.96, g: 0.96, b: 0.96, a: 1.0)
let kChatBarOriginHeight = 49.0 // 工具条高度
let kTextViewMaxHeight = 100    // 聊天框最大高度
let kTextViewMinHeiht = kChatBarOriginHeight - 14.0 // 聊天框最小高度

// 键盘类型
enum ChatKeyboardType: Int {
    case nothing
    case voice
    case text
    case emoj
    case more
}




