//
//  ChatConversationManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/12/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatConversationManager: NSObject {
    
    let `default`: ChatConversationManager = {
        let cm = ChatConversationManager()
        NIMSDK.shared().conversationManager.add(cm as NIMConversationManagerDelegate)
        return cm
    }()
    
    /** 获取本低历史消息*/
    func getLocalMsgs(msg: NIMMessage? = nil) -> [NIMMessage]? {
        guard let sion = ChatMsgManager.default.session else { return nil }
        return NIMSDK.shared().conversationManager.messages(in: sion, message: msg, limit: 10)
    }
    /** 获取服务器历史消息*/
    func getCloudMsg(msg: NIMMessage? = nil,reslut: @escaping (Error?, [NIMMessage]?)->()) {
        guard let sion = ChatMsgManager.default.session else { return }
        
        let option = NIMHistoryMessageSearchOption()
        option.endTime = msg?.timestamp ?? 0
        option.limit = 10
        option.currentMessage = msg
        option.order = .desc
        option.sync = true
        NIMSDK.shared().conversationManager.fetchMessageHistory(sion, option: option) { (error, msgs) in
            //            msgs?.reversed()
        }
        
    }
}

extension ChatConversationManager: NIMConversationManagerDelegate {
    
}
