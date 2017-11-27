//
//  ChatManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/23.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

// cell类型
enum ChatCellType: String {
    case time = "IMTimeCell"
    case text = "IMTextCell"
    case voice = "IMVoiceCell"
    case image = "IMImageCell"
    case video = "IMVideoCell"
}

class ChatManager {
    let `default` = ChatManager()
    
}
