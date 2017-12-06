//
//  ChatMsgManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/12/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import SwiftDate
// cell类型
enum ChatCellType: String {
    case time = "IMTimeCell"
    case text = "IMTextCell"
    case voice = "IMVoiceCell"
    case image = "IMImageCell"
    case video = "IMVideoCell"
    case location = "IMLocation"
}
class ChatMsgManager: NSObject {
    
    static let `default` : ChatMsgManager = {
        let cm = ChatMsgManager()
        NIMSDK.shared().chatManager.add(cm as NIMChatManagerDelegate)
        return cm
    }()
    
    /** 会话对象*/
    private(set) var session: NIMSession?
    /** 消息数组*/
    private(set) var messageSource: [ChatMessage]?
    
    public func addSession(_ session: NIMSession) {
        self.session = session
    }
    
    public func removeSession() {
        self.session = nil
    }
    
    
}


extension ChatMsgManager {
    /** 发送文本*/
    class func sendText(text: String) {
        let msg = NIMMessage()
        msg.text =  text
        sendMessage(message: msg)
    }
    /** 发送图片*/
    class func sendImage(image: UIImage) {
        let option = NIMImageOption()
        option.compressQuality = 0.7
        let obj = NIMImageObject(image: image)
        obj.option = option
        let msg = NIMMessage()
        msg.messageObject = obj
        msg.apnsContent = "发来一张图片"
        sendMessage(message: msg)
    }
    /** 发送音频*/
    class func sendAudio(filePath: String) {
        let msg = NIMMessage()
        let obj = NIMAudioObject(sourcePath: filePath)
        msg.messageObject = obj
        msg.apnsContent = "发来一段语音"
        sendMessage(message: msg)
    }
    
    /** 发送视频*/
    class func sendVideo(filePath: String) {
        let newDate =  DateInRegion().string(format: .custom("yyyy-MM-dd HH:mm"))
        let obj = NIMVideoObject(sourcePath: filePath)
        obj.displayName = "视频发送于\(newDate)"
        let msg = NIMMessage()
        msg.messageObject = obj
        msg.apnsContent = "发来一段视频"
        sendMessage(message: msg)
    }
    
    /** 发送位置*/
    class func sendLocation(location: NIMLocationObject) {
        let msg = NIMMessage()
        msg.messageObject = location
        msg.apnsContent = "发送一条位置信息"
        sendMessage(message: msg)
    }
    
    private class func sendMessage(message: NIMMessage) -> Void {
        guard let seion = ChatMsgManager.default.session else { return }
        do {
            try NIMSDK.shared().chatManager.send(message, to: seion)
        } catch let err {
            printLog("发送失败error: \(err)")
        }
    }
}

extension ChatMsgManager: NIMChatManagerDelegate {
    
    func willSend(_ message: NIMMessage) {
        
    }
    /** 发送消息进度回调*/
    func send(_ message: NIMMessage, progress: Float) {
        
    }
    /** 发送消息完成回调*/
    func send(_ message: NIMMessage, didCompleteWithError error: Error?) {
        
    }
    /** 收到消息回调*/
    func onRecvMessages(_ messages: [NIMMessage]) {
        
    }
    /** 收到消息回执*/
    func onRecvMessageReceipt(_ receipt: NIMMessageReceipt) {
        
    }
    /** 收到消息被撤回的通知,会先从本地数据库中找到对应消息并进行删除*/
    func onRecvRevokeMessageNotification(_ notification: NIMRevokeMessageNotification) {
        
    }
    /** 收取消息附件回调,进度*/
    func fetchMessageAttachment(_ message: NIMMessage, progress: Float) {
        
    }
    /** 收取消息附件完成回调*/
    func fetchMessageAttachment(_ message: NIMMessage, didCompleteWithError error: Error?) {
        
    }
}

extension ChatMsgManager {
    
    
    
}

