//
//  LivelistModel.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class LivelistModel: NSObject {
    var small_icon_url = ""
    var tag_name = ""
    var icon_url = ""
    var tag_id = ""
    var vedioData = [LiveDetail]()
}

class LiveDetail: NSObject {
    var nickname = ""
    var room_src = ""
    var room_id = ""
    var avatar_small = ""
    
}

class ViewListModel: NSObject {
    
    
    /// 直播视频流
    var shareAddr:String!
    /* 关注人 */
    var onlineUsers:Int!
    /* 城市 */
    var city:String!
    /* 主播 */
    var creator:CreatorItem!
    
    init(dataDic: JSON?) {
        
        if let creatorInfo = dataDic {
            shareAddr = creatorInfo["stream_addr"].string
            onlineUsers = creatorInfo["online_users"].int
            city = creatorInfo["city"].string
            creator = CreatorItem(creator: creatorInfo["creator"])
        }
        
    }
    
}

class CreatorItem: NSObject {
    
    
    /// 主播名
    var nick:String!
    /// 主播头像
    var portrait:String!
    init(creator: JSON) {
        nick = creator["nick"].string
        portrait = creator["portrait"].string
    }
}
