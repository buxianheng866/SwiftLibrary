//
//  ChatMessage.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

let kImgMaxW: CGFloat = 125 //最大图片宽度
let kImgMinW: CGFloat = 50  //最小图片宽度
let kImgMaxH: CGFloat = 150 //最大的图片宽度
let kImgMinH: CGFloat = 50  //最小图片宽度


class ChatMessage {
    
    var message: NIMMessage! {
        didSet {
            switch message.messageType {
            case .image:
                let imgObj = message.messageObject as! NIMImageObject
                if let lp = imgObj.path {
                   orgLocImg = UIImage(contentsOfFile: lp)
                }
                if let tp = imgObj.thumbPath {
                    locthumbImg = UIImage(contentsOfFile: tp)
                }
                thumbSize = cutThumbImgSize(imgObj.size)
                orgImgSize = imgObj.size
            case .audio:
                let aduObj = message.messageObject as! NIMAudioObject
                audioPath = aduObj.path
                audioDuration = aduObj.duration/1000
            case .video:
                let videoObj = message.messageObject as! NIMVideoObject
                videoName = videoObj.displayName
                locVideoPath = videoObj.path
                orgVideoUrl = videoObj.url
                videoImgLocUrl = videoObj.coverPath
                videoImgOrgUrl = videoObj.coverUrl
                videoImgSize = cutThumbImgSize(videoObj.coverSize)
                videoDuration = videoObj.duration / 1000
            default: break
            }
        }
    }
    var frame: MessageFrame!
    
    var msgType: NIMMessageType! {
        return message.messageType
    }
    /** 消息发送状态 本人发送的消息*/
    var msgSate: NIMMessageDeliveryState! {
        return message.deliveryState
    }
    
    var nickName: String? {
        return message.from
    }
    
    var localExt: [String: String]? {
        return message.localExt as? [String: String]
    }
    
    /** 用于头像左右排版 true 自己  false 其他人*/
    var isSender: Bool! {
        return message.isOutgoingMsg
    }
   /*============== 文字 =================*/
    var text: String? {
        return message.text
    }
   /*============== 图片 =================*/
    /** 本地图片原*/
    var orgLocImg: UIImage?
    /** 本地缩略图*/
    var locthumbImg: UIImage?
    /** 缩略图大小*/
    var thumbSize: CGSize?
    /** 原图片大小*/
    var orgImgSize: CGSize?
    /** 文件大小*/
    var fileLength: Int64?
    
    /*============== 音频 =================*/
    /** 本地音频路径*/
    var audioPath: String?
    /** 音频时长, */
    var audioDuration: Int = 0
   /*============== 视频 =================*/
    /** 视频名称*/
    var videoName: String?
    /** 本地视频路径*/
    var locVideoPath: String?
    /** 远程视频路径*/
    var orgVideoUrl: String?
    /** 本地视频封面*/
    var videoImgLocUrl: String?
    /** 远程视频封面*/
    var videoImgOrgUrl: String?
    /** 视频图片*/
    var videoImgSize: CGSize?
    /** 视频时长 秒单位*/
    var videoDuration: Int?
    
    init(msg: NIMMessage) {
        message = msg
        frame = MessageFrame(msg: self)
    }
}

class MessageFrame: NSObject {
    /** cell高度*/
    var cellHeight: CGFloat = 0
    /** 头像*/
    var headerF: CGRect?
    /** 姓名*/
    var nameF: CGRect?
    /** 气泡*/
    var bubbleF: CGRect?
    /** 文字*/
    var textLabF: CGRect?
    /** 菊花*/
    var acivityF: CGRect?
    /** 重发*/
    var retryF: CGRect?
    /** 图片*/
    var imageF: CGRect?
    /** 语音按钮*/
    var voiceF: CGRect?
    /** 语音时长*/
    var voiceTimeF: CGRect?
    /** 视频播放按钮*/
    var videoPlayF: CGRect?
    /** 视频时长*/
    var videoDuration: CGRect?
    
    init(msg: ChatMessage) {
        super.init()
        if let dict = msg.localExt {
            setValuesForKeys(dict)
        } else {
            getValue(msg: msg)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    private func getValue(msg: ChatMessage) -> Void {
        
        let headToView: CGFloat = 10
        let headToBub: CGFloat = 8
        let headW:CGFloat = 50
        let cellMar:CGFloat = 10
        let bubblePadding: CGFloat = 10
        let textMax = mScreenW - headW - 100
        let arrowW: CGFloat = 7 //气泡箭头
        let topMar: CGFloat = 10
        let imageMar: CGFloat = 4
        if msg.isSender {
            let headX = mScreenW - headToView - headW
            switch msg.msgType {
            case .text:
                let textSize = (msg.text! as NSString).size(for: UIFont.systemFont(ofSize: 16), size: CGSize(width: textMax, height: CGFloat(MAXFLOAT)), mode: .byWordWrapping)
                let bubSize = CGSize(width: textSize.width + bubblePadding * 2 + arrowW, height: textSize.height + bubblePadding * 2)
                bubbleF = CGRect(x: headX - headToBub - bubSize.width, y: cellMar + topMar, width: bubSize.width, height: bubSize.height)
                textLabF = CGRect(x: (bubbleF?.origin.x)! + bubblePadding, y: topMar + cellMar + bubblePadding, width: textSize.width, height: textSize.height)
            case .image:
                let bubbleX = headX - headToBub - (msg.thumbSize?.width)! - imageMar * 2
                bubbleF = CGRect(x: bubbleX, y: cellMar + topMar, width: (msg.thumbSize?.width)! + imageMar * 2, height: (msg.thumbSize?.height)! + imageMar * 2)
                imageF = CGRect(x: (bubbleF?.origin.x)! + imageMar, y: cellMar + topMar + imageMar, width: (msg.thumbSize?.width)!, height: (msg.thumbSize?.height)!)
                
            case .audio:
                let len = formatAudioTime(duration: msg.audioDuration)
                voiceF = CGRect(x: headX - headToBub - len, y: cellMar + topMar, width: len, height: 50)
                voiceTimeF = CGRect(x: (voiceF?.origin.x)! - 40 - 5, y: (voiceF?.origin.y)!, width: 40, height: 40)
                
            case .video:
                let bubbleX = headX - headToBub - (msg.videoImgSize?.width)! - imageMar * 2
                bubbleF = CGRect(x: bubbleX, y: cellMar + topMar, width: (msg.videoImgSize?.width)! + imageMar * 2, height: (msg.videoImgSize?.height)! + imageMar * 2)
                imageF = CGRect(x: (bubbleF?.origin.x)! + imageMar, y: cellMar + topMar + imageMar, width: (msg.videoImgSize?.width)!, height: (msg.videoImgSize?.height)!)
                videoPlayF = CGRect(x: (imageF?.size.width)! / 2 - 20, y: (imageF?.size.height)! / 2 - 20, width: 40, height: 40)
//                videoDuration
            default:
                printLog("other")
            }
            
            acivityF = CGRect(x: (bubbleF?.origin.x)! - 40, y: ((bubbleF?.origin.y)! + (bubbleF?.size.height)!) / 2 - 5, width: 40, height: 40)
            retryF = acivityF
            if (bubbleF?.size.height)! > CGFloat(40) {
                headerF = CGRect(x: headX, y: ((bubbleF?.origin.y)! + (bubbleF?.size.height)!) - headW, width: headW, height: headW)
            } else {
                headerF = CGRect(x: headX, y: cellMar, width: headW, height: headW)
            }
        } else {
            
            let headMaxX = headToView + headW + headToBub
            switch msg.msgType {
            case .text:
                
                let textSize = (msg.text! as NSString).size(for: UIFont.systemFont(ofSize: 16), size: CGSize(width: textMax, height: CGFloat(MAXFLOAT)), mode: .byWordWrapping)
                let bubSize = CGSize(width: textSize.width + bubblePadding * 2 + arrowW, height: textSize.height + bubblePadding * 2)
                bubbleF = CGRect(x: headMaxX + bubSize.width, y: cellMar + topMar, width: bubSize.width, height: bubSize.height)
                textLabF = CGRect(x: (bubbleF?.origin.x)! + bubblePadding, y: topMar + cellMar + bubblePadding, width: textSize.width, height: textSize.height)
            case .image:
                
                bubbleF = CGRect(x: headMaxX, y: cellMar + topMar, width: (msg.thumbSize?.width)! + imageMar * 2, height: (msg.thumbSize?.height)! + imageMar * 2)
                imageF = CGRect(x: (bubbleF?.origin.x)! + imageMar, y: cellMar + topMar + imageMar, width: (msg.thumbSize?.width)!, height: (msg.thumbSize?.height)!)
            case .audio:
                
                let len = formatAudioTime(duration: msg.audioDuration)
                voiceF = CGRect(x: headMaxX, y: cellMar + topMar, width: len, height: 50)
                voiceTimeF = CGRect(x: (voiceF?.origin.x)! + len + 5, y: (voiceF?.origin.y)!, width: 40, height: 40)
            case .video:
                
                bubbleF = CGRect(x: headMaxX, y: cellMar + topMar, width: (msg.videoImgSize?.width)! + imageMar * 2, height: (msg.videoImgSize?.height)! + imageMar * 2)
                imageF = CGRect(x: (bubbleF?.origin.x)! + imageMar, y: cellMar + topMar + imageMar, width: (msg.videoImgSize?.width)!, height: (msg.videoImgSize?.height)!)
                videoPlayF = CGRect(x: (imageF?.size.width)! / 2 - 20, y: (imageF?.size.height)! / 2 - 20, width: 40, height: 40)

            default:
                printLog("other")
            }
            
            acivityF = CGRect(x: (bubbleF?.origin.x)! - 40, y: ((bubbleF?.origin.y)! + (bubbleF?.size.height)!) / 2 - 5, width: 40, height: 40)
            retryF = acivityF
            if (bubbleF?.size.height)! > CGFloat(40) {
                headerF = CGRect(x: headToView, y: ((bubbleF?.origin.y)! + (bubbleF?.size.height)!) - headW, width: headW, height: headW)
            } else {
                headerF = CGRect(x: headToView, y: cellMar, width: headW, height: headW)
            }
        }
    }
    
}

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
        return 80
    } else if duration > 20 && duration < 40 {
        return 120
    } else {
        return 160
    }
}


