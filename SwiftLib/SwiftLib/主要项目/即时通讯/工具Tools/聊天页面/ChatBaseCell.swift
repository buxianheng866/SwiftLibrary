//
//  ChatBaseCell.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class ChatBaseCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** 头像*/
    lazy var headerImage: UIImageView = {
        return UIImageView()
    }()
    /** 用户名*/
    lazy var userName: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = UIColor.black
        return lab
    }()
    /** 气泡*/
    var bubbleImage: UIImageView = {
        return UIImageView()
    }()
    /** 信息正在发送*/
    var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return activity
    }()
    /** 重新发送*/
    var retrybtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "button_retry"), for: .normal)
        btn.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        return btn
    }()
    
    var message: ChatMessage? {
        didSet {
            guard let md = message else { return }
            
        }
    }
    
}

extension ChatBaseCell {
    @objc func retryAction() -> Void {
        printLog("重新发送")
    }
}
