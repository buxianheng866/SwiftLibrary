//
//  ChatCellImage.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatCellImage: ChatBaseCell {
    public lazy var imageView: UIImageView = {
        let imgv = UIImageView()
        imgv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImgView))
        imgv.addGestureRecognizer(tap)
        return imgv
    }()
    
    override var message: ChatMessage? {
        didSet {
            if let md = message {
                imageView.image = md.locthumbImg
                let stretchImg = md.isSender ? #imageLiteral(resourceName: "SenderImageNodeMask") : #imageLiteral(resourceName: "ReceiverImageNodeMask")
                let inserts = UIEdgeInsets(top: 30, left: 28, bottom: 23, right: 28)
                imageView.clipShape(stretchImage: stretchImg, stretchInsets: inserts)
                
                let stretchCoverImg = md.isSender ? #imageLiteral(resourceName: "SenderImageNodeBorder") : #imageLiteral(resourceName: "ReceiverImageNodeBorder")
                bubbleImage.image = stretchCoverImg.resizableImage(withCapInsets: inserts, resizingMode: .stretch)
            }
        }
    }
    
    override func setUI() {
        super.setUI()
        contentView.addSubview(imageView)
    }
    
 
    
    @objc func tapImgView() -> Void {
        printLog("点击图片")
    }
}
