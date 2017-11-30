//
//  CM+FormattMessage.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
let kImgMaxW: CGFloat = 125 //最大图片宽度
let kImgMinW: CGFloat = 50  //最小图片宽度
let kImgMaxH: CGFloat = 150 //最大的图片宽度
let kImgMinH: CGFloat = 50  //最小图片宽度

/** cell显示相关*/
extension ChatManager {
    /** 裁剪聊天缩略图*/
    func cutThumbImgSize(_ orgSize: CGSize) -> CGSize {
        var newW: CGFloat = 0
        var newH: CGFloat = 0
        if orgSize.height >= orgSize.height {
            let scalW = orgSize.width * kImgMaxH / orgSize.height
            newW = scalW > kImgMinW ? scalW : kImgMinW
            newH = kImgMaxH
        } else {
            let sclH = orgSize.height * kImgMaxW / orgSize.width
            newH = sclH > kImgMinH ? sclH : kImgMinH
            newW = kImgMaxW
        }
        
        return CGSize(width: newW, height: newH)
    }
    
  
    
    
    /** 长度from音频时长*/
    func formatAudioTime(duration: Int) -> CGFloat {
        if duration <= 20 {
            return 70
        } else if duration > 20 && duration < 40 {
            return 110
        } else {
            return 150
        }
    }
}


/** 数据操作相关*/
extension ChatManager {
    
    
    
    
}

