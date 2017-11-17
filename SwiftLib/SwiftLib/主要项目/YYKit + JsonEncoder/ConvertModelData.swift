//
//  ConvertModelData.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/1.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
class ConvertModelData {
    
    class func loadData() -> Void {
        let netUrl = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
        request(netUrl).jsonResponse { result in
            switch result {
            case .success(let value):
//                printLog(value)
//                let md = ModelData.model(withJSON: JSON(value))
//                if let x = md {
//                    printLog(x)
//                } else {
//                    printLog("hahhahah")
//                }
//
            let _ = ModelData()
           
              printLog(value)
            default:
                printLog("error")
            }
        }
    }
}

class ModelData: NSObject {
    var dm_error: String?
    var error_msg: String?
    var expire_time: String?
    var lives: [LiveContent]?
    
}

class LiveContent: NSObject {
    var uid: String = "act_info.uid"
    var city: String?
    var stream_addr: String?
    var share_addr: String?
    var creator: creatorModel?
}

class creatorModel: NSObject {
    var nick:String!
    var portrait:String!
    var level: String?
    
}

