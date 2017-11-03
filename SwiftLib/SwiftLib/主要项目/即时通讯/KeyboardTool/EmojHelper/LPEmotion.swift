//
//  LPEmotion.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class LPEmotion: NSObject {
    
    var text: String? //表情对应的文字
    var imgPath: String?
    var isRemove: Bool = false //删除按钮
    var isEmpty: Bool = false  //占位
    
    var image: String? {
        didSet {
            imgPath = Bundle.main.bundlePath + "/Expression.bundle/" + image! + ".png"
        }
    }
    
    init(empty: Bool) {
        isEmpty = empty
    }
    
    init(remove: Bool) {
        isRemove = remove
    }

     init(dict: [String : String]) {
        super.init()
        self.text = dict["text"]
        self.image = dict["image"]
        imgPath = Bundle.main.bundlePath + "/Expression.bundle/" + image! + ".png"
    }
    
}
