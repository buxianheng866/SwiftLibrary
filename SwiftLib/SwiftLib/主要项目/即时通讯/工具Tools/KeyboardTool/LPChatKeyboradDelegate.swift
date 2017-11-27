//
//  LPChatKeyboradDelegate.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/11.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

protocol LPChatKeyboradDelegate: NSObjectProtocol {
    
    /** 发送消息*/
    func sendMessage(messg: String)
    
    /** 滚到底部*/
    func aboveViewScrollToBottom()
}
