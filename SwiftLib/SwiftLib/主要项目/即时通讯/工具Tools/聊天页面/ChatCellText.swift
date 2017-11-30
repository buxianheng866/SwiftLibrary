//
//  ChatCellText.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatCellText: ChatBaseCell {
    
    override var message: ChatMessage? {
        didSet {
            guard let msg = message else { return }
            textLab.frame = msg.frame.textLabF!
            textLab.text = msg.text!
        }
    }
    
   private lazy var textLab: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.lightGray
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.numberOfLines = 0
        lb.lineBreakMode = .byCharWrapping
        lb.text = "2010年9月23日"
        return lb
    }()
    
    override func setUI() {
        super.setUI()
        contentView.addSubview(textLab)
    }
    
}
