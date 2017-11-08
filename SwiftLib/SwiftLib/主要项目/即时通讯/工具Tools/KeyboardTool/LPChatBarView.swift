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
    func chatKeyBoardSendMessage(message: String)
    func chatBarUpdateHeight(height: CGFloat)
}

class LPChatBarView: UIView {
    
    lazy var keybordType: ChatKeyboardType = self.obtainKeyboardType()
    
    weak var keyBoardDelegate: ChatKeyboardDelegate?

    fileprivate var currentHeight: CGFloat = kChatBarOriginHeight
    
//    TypeSelectorBtn_Black ToolViewKeyboardHL
    
    fileprivate lazy var voiceBtn: UIButton = {
        return self.obtaionBtn(#imageLiteral(resourceName: "ToolViewInputVoice"), bImg: #imageLiteral(resourceName: "ToolViewInputVoiceHL"), method: #selector(voiceBtnSelect(_:)))
    }()
    
    fileprivate lazy var emojBtn: UIButton = {
        return self.obtaionBtn(#imageLiteral(resourceName: "ToolViewEmotion"), bImg: #imageLiteral(resourceName: "ToolViewEmotionHL"), method: #selector(emojBtnSelect(_:)))
    }()
    
    fileprivate lazy var moreBtn: UIButton = {
        return self.obtaionBtn(#imageLiteral(resourceName: "TypeSelectorBtn_Black"), bImg: #imageLiteral(resourceName: "TypeSelectorBtnHL_Black"), method: #selector(moreBtnSelect(_:)))
    }()
    
    fileprivate lazy var recordBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("按住 说话", for: .normal)
        btn.setTitle("松开 结束", for: .highlighted)
        btn.setBackgroundImage(RGBA(r: 0.7, g: 0.7, b: 0.7, a: 0.5).transImage(), for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(RGBA(r: 0.3, g: 0.3, b: 0.3, a: 1.0), for: .normal)
        btn.layer.cornerRadius = 4.0
        btn.layer.masksToBounds = true
        btn.layer.borderColor = kSplitLineColor.cgColor
        btn.layer.borderWidth = 0.5
        btn.isHidden = true
        btn.addTarget(self, action: #selector(recordBtnDown), for: .touchDown)
        btn.addTarget(self, action: #selector(recordBtnUpInside), for: .touchUpInside)
        btn.addTarget(self, action: #selector(recordBtnUpOutSide), for: .touchUpOutside)
        btn.addTarget(self, action: #selector(recordBtnDragInSide), for: .touchDragInside)
        btn.addTarget(self, action: #selector(recordBtnUpOutSide), for: .touchUpOutside)

        return btn
    }()
    
    fileprivate lazy var inputTextView: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = UIColor.black
        text.returnKeyType = .send
        text.layer.cornerRadius = 4.0
        text.layer.masksToBounds = true
        text.layer.borderColor = kSplitLineColor.cgColor
        text.layer.borderWidth = 0.5
        text.delegate = self
        text.scrollsToTop = false

        
//        text.addObserver(self, forKeyPath: "attributedText", options: .new, context: nil)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        printLog("chatbarView销毁了")
//        UserDefaults.standard.set(keybordType, forKey: U_keyboradType)
    }
}


extension LPChatBarView {
    @objc fileprivate func voiceBtnSelect(_ btn: UIButton) -> Void {
        printLog("voice")
    }
    
    @objc fileprivate func emojBtnSelect(_ btn: UIButton) -> Void {
        printLog("emoji")
    }

    @objc fileprivate func moreBtnSelect(_ btn: UIButton) -> Void {
        printLog("更多")
    }
    
    @objc fileprivate func recordBtnDown() -> Void {
        
    }
    
    @objc fileprivate func recordBtnUpInside() -> Void {
        
    }
    
    @objc fileprivate func recordBtnUpOutSide() -> Void {
        
    }
    
    @objc fileprivate func recordBtnDragOutSide() -> Void {
        
    }
    
    @objc fileprivate func recordBtnDragInSide() -> Void {
        
    }
    
    override func resignFirstResponder() -> Bool {
        self.inputTextView.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    private func obtainKeyboardType() -> ChatKeyboardType {
        let type = UserDefaults.standard.object(forKey: U_keyboradType) as? ChatKeyboardType
        if let tp = type {
            return tp
        }
        return .nothing
    }
}

extension LPChatBarView {
    fileprivate func obtaionBtn(_ aImg: UIImage, bImg: UIImage, method: Selector) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setImage(aImg, for: .normal)
        btn.setImage(bImg, for: .highlighted)
        btn.addTarget(self, action: method, for: .touchUpInside)
        return btn
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    fileprivate func setUI() -> Void {
        self.backgroundColor = kChatKeyboardBgColor
        addSubview(voiceBtn)
        addSubview(inputTextView)
        addSubview(recordBtn)
        addSubview(emojBtn)
        addSubview(moreBtn)
        
        voiceBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(5)
            make.width.height.equalTo(35)
            make.bottom.equalTo(self.snp.bottom).offset(-7)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-5)
            make.width.height.equalTo(35)
            make.bottom.equalTo(self.snp.bottom).offset(-7)
        }

        emojBtn.snp.makeConstraints { (make) in
            make.right.equalTo(moreBtn.snp.left)
            make.width.height.equalTo(35)
            make.bottom.equalTo(moreBtn)
        }

        inputTextView.snp.makeConstraints { (make) in
            make.left.equalTo(voiceBtn.snp.right).offset(7)
            make.right.equalTo(emojBtn.snp.left).offset(-7)
            make.top.equalTo(self.snp.top).offset(3)
            make.bottom.equalTo(self.snp.bottom).offset(-3)
        }

        recordBtn.snp.makeConstraints { (make) in
            make.right.equalTo(inputTextView.snp.right)
            make.left.equalTo(inputTextView.snp.left)
            make.height.equalTo(35)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        for i in 0..<2 {
            let line = UIView()
            line.backgroundColor = kSplitLineColor
            self.addSubview(line)
            if i == 0 {
                line.snp.makeConstraints({ (make) in
                    make.left.right.top.equalTo(0)
                    make.height.equalTo(0.5)
                })
            } else {
                line.snp.makeConstraints({ (make) in
                    make.left.right.bottom.equalTo(0)
                    make.height.equalTo(0.5)
                })
            }
        }
    }
    
}

extension LPChatBarView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            printLog("发送")
            let mesg = textView.getEmotionString()
            if !mesg.isEmpty {
                keyBoardDelegate?.chatKeyBoardSendMessage(message: mesg)
                textView.text = ""
            }
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
    //      sizeThatFits 会计算出最优的 size
        var fixH = textView.sizeThatFits(textView.size).height
          printLog(fixH)
//        fixH = fixH > kTextViewMinHeight ? fixH : kTextViewMinHeight
//        fixH = fixH < kTextViewMaxHeight ? fixH : kTextViewMaxHeight
//        currentHeight = fixH + kChatBarOriginHeight - kTextViewMinHeight
//        if currentHeight != textView.height {
//            UIView.animate(withDuration: 0.05, animations: {
//                self.keyBoardDelegate?.chatBarUpdateHeight(height: self.currentHeight)
//            })
//        }
        
        
        let str = textView.text as NSString
        let size = str.size(for: UIFont.systemFont(ofSize: 15), size: CGSize(width: 300, height: 1000), mode: .byCharWrapping)
        printLog(size)
      
//
//
//        let paraStyle = NSMutableParagraphStyle()
//        paraStyle.lineBreakMode = .byCharWrapping
//        let attr = [NSAttributedStringKey.paragraphStyle: paraStyle, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
//        textView.attributedText = NSAttributedString(string: textView.text, attributes: attr)
//        textView.textContainerInset = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0)
     
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        keybordType = .text
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        self.textViewDidChange(inputTextView)
    }
    
}


