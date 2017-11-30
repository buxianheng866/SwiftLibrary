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
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /** 头像*/
    lazy var headerImage: UIImageView = {
        return UIImageView()
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
            headerImage.frame = md.frame.headerF!
            bubbleImage.frame = md.frame.bubbleF!
            if md.isSender == true {
                activity.frame = md.frame.acivityF!
                retrybtn.frame = md.frame.retryF!
                self.bubbleImage.image = #imageLiteral(resourceName: "message_sender_background_normal")
                if let state = message?.msgSate {
                    switch state {
                    case .deliveried:
                        retrybtn.isHidden = true
                        activity.isHidden = true
                        activity.stopAnimating()
                    case .delivering:
                        retrybtn.isHidden = true
                        activity.isHidden = false
                        activity.startAnimating()
                    case .failed:
                        retrybtn.isHidden = false
                        activity.isHidden = true
                        activity.stopAnimating()
                    }
                }
                headerImage.backgroundColor = UIColor.orange
            } else {
                self.bubbleImage.image = #imageLiteral(resourceName: "message_receiver_background_normal")
                headerImage.backgroundColor = UIColor.green
            }
        }
    }
    
    func setUI() {
        contentView.addSubview(headerImage)
        contentView.addSubview(bubbleImage)
        contentView.addSubview(activity)
        contentView.addSubview(retrybtn)
    }
    
}

extension ChatBaseCell {
    @objc func retryAction() -> Void {
        printLog("重新发送")
    }
}
