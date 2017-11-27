//
//  ChatMessage.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatMessage: NSObject {
    
    
    var message: NIMMessage!
    var frame: MessageFrame? /** cell的frame*/
    
    
    var msgType: NIMMessageType! {
        return message.messageType
    }
    
    var msgSate: NIMMessageDeliveryState! {
        return message.deliveryState
    }
    
    var nickName: String? {
        return message.from
    }
    
    
    
    
    
    init(msg: NIMMessage) {
        message = msg
    }
}


struct MessageFrame {
    var cellHeight: CGFloat = 0 /** cell高度*/
    var headerF = CGRect.zero   /** 头像*/
    var nameF = CGRect.zero     /** 姓名*/
    var textLabF = CGRect.zero  /** 文字*/
    var acivityF = CGRect.zero  /** 菊花*/
    var retryF = CGRect.zero    /** 重发*/
    var imageF = CGRect.zero    /** 图片*/
    var voiceF = CGRect.zero    /** 语音图标*/
    var voice = CGRect.zero     /** 语音*/
    var voiceSeconds = CGRect.zero  /** 秒数*/
    var videoF: CGRect = CGRect.zero   /** 视频播放按钮*/
    init(msg: NIMMessage) {
        
    }
    
}


