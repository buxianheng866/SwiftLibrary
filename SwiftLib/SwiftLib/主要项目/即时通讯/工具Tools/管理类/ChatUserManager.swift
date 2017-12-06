//
//  ChatUserManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/12/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatUserManager: NSObject {
    let `default`: ChatUserManager = {
        let cm = ChatUserManager()
        NIMSDK.shared().userManager.add(cm as NIMUserManagerDelegate)
        return cm
    }()
    
}

extension ChatUserManager: NIMUserManagerDelegate {
    
}
