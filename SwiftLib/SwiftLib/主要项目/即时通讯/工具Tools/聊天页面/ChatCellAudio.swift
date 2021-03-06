//
//  ChatCellVoice.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatCellAudio: ChatBaseCell {
    
    lazy var audioBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(voiceSelect), for: .touchUpInside)
        return btn
    }()
    
    lazy var durationLab: UILabel = {
        let lab = UILabel()
        
        return lab
    }()
    
    lazy var redDot: CALayer = {
        let lay = CALayer()
        lay.isHidden = true
        lay.backgroundColor = UIColor.red.cgColor
        return lay
    }()
    
    
    override var message: ChatMessage? {
        didSet {
            if let md = message {
                audioBtn.frame = md.frame.voiceF!
                durationLab.frame = md.frame.voiceTimeF!
                durationLab.text = "\(md.audioDuration)''"
                if md.isSender == true {
                    audioBtn.setBackgroundImage(#imageLiteral(resourceName: "message_sender_background_normal"), for: .normal)
                } else {
                    audioBtn.setImage(#imageLiteral(resourceName: "message_receiver_background_normal"), for: .normal)
                }
            }
        }
    }
    
    override func setUI() {
        super.setUI()
        contentView.addSubview(audioBtn)
        contentView.addSubview(durationLab)
        contentView.layer.addSublayer(redDot)
        bubbleImage.removeFromSuperview()
    }
    
    @objc func voiceSelect() -> Void {
        printLog("点击语音")
    }
    
}
