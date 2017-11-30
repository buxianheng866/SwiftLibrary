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
        let btn = UIButton(type: .custom)
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
            
        }
    }
    
    
    override func setUI() {
        super.setUI()
        contentView.addSubview(audioBtn)
        contentView.addSubview(durationLab)
        contentView.layer.addSublayer(redDot)
    }
    
    
}
