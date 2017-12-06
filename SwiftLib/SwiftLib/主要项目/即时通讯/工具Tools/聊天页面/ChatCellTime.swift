//
//  ChatCellTime.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatCellTime: UICollectionViewCell {
    lazy var timeLab: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.text = "2010年9月23日"
        return lb
    }()
    
    lazy var imgBG: UIImageView = {
        let img = UIImageView()
        /** 图片拉伸 stretch 拉伸模式, tile 平铺模式*/
        img.image = #imageLiteral(resourceName: "message_time_bg").resizableImage(withCapInsets: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20), resizingMode: .stretch)
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgBG)
        contentView.addSubview(timeLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var time: ChatTime? {
        didSet {
            guard let time = time else { return }
            timeLab.text = time.time
            timeLab.sizeToFit()
            timeLab.center = CGPoint(x: self.centerX, y: 20)
            imgBG.frame = CGRect(x: timeLab.left - 7, y: timeLab.top - 2, width: timeLab.width + 14, height: timeLab.height + 4)
        }
    }
    
}
