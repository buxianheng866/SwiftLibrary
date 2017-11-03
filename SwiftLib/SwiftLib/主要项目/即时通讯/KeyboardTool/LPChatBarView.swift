//
//  LPChatBarView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import SnapKit
import YYKit
protocol ChatKeyboardDelegate: NSObjectProtocol {
    
}

class LPChatBarView: UIView {
    var keybordType: ChatKeyboardType = .nothing
    weak var keyBoardDelegate: ChatKeyboardDelegate?
    
    var currentHeight: CGFloat = kChatBarOriginHeight
    
    lazy var voiceBtn: UIButton = {
        return self.obtaionBtn(#imageLiteral(resourceName: "ToolViewInputVoice"), bImg: #imageLiteral(resourceName: "ToolViewInputVoiceHL"), method: #selector(voiceBtnSelect(_:)))
    }()
    
    lazy var emojBtn: UIButton = {
        return self.obtaionBtn(#imageLiteral(resourceName: "ToolViewEmotion"), bImg: #imageLiteral(resourceName: "ToolViewEmotionHL"), method: #selector(emojBtnSelect(_:)))
    }()
    
    lazy var recordBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.white
        btn.setTitle("按住 说话", for: .normal)
        btn.setTitle("松开 结束", for: .highlighted)
        btn.setBackgroundImage(UIColor.hexInt(0xF3F4F8).transImage(), for: .normal)
        btn.setBackgroundImage(UIColor.hexInt(0xC6C7CB).transImage(), for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.tintColor = RGBA(r: 0.3, g: 0.3, b: 0.3, a: 1.0)
        btn.layer.cornerRadius = 4.0
        btn.layer.masksToBounds = true
        btn.layer.borderColor = kSplitLineColor.cgColor
        btn.layer.borderWidth = 0.5
        btn.isHidden = true
        return btn
    }()
    
    lazy var inputTextView: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = UIColor.black
        text.returnKeyType = .send
        text.layer.cornerRadius = 4.0
        text.layer.masksToBounds = true
        text.layer.borderColor = kSplitLineColor.cgColor
        text.layer.borderWidth = 0.5
        text.delegate = self
        text.addObserverBlock(forKeyPath: "attributedText", block: { (a, b, c) in
            
        })
        return text
    }()
}

extension LPChatBarView {
    @objc func voiceBtnSelect(_ btn: UIButton) -> Void {
        
    }
    
    @objc func emojBtnSelect(_ btn: UIButton) -> Void {
        
    }
    
}

extension LPChatBarView {
    func obtaionBtn(_ aImg: UIImage, bImg: UIImage, method: Selector) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setImage(aImg, for: .normal)
        btn.setImage(bImg, for: .highlighted)
        btn.addTarget(self, action: method, for: .touchUpInside)
        return btn
    }
}
extension LPChatBarView: UITextViewDelegate {
    
}

