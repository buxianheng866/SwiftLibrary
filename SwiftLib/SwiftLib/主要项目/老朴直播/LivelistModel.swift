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
