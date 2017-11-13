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
// 键盘类型

enum ChatKeyboardType: Int {
    case normal  = 1// 显示textView 键盘不弹出
    case voice  // 录音按钮显示
    case text   // 键盘弹出
    case emoj   // 表情键盘
    case more   // 更多键盘
}

protocol ChatKeyboardDelegate: NSObjectProtocol {
    
    // 发送消息
    func chatKeyBoardSendMessage(message: String)
    // 更新高度
    func chatBarUpdateHeight(height: CGFloat)
    // 录音
    func chatBarStartRecord()
    func chatBarStopRecord()
    func chatBarCancelRecord()
    func chatBarDragInside(inside: Bool)
    
    // 点击按钮
    func chatBarSelectMoreBtn()
    func chatBarSelectEmojBtn()
    func chatBarSelectVoiceBtn()
    func chatBarSelectText()
}
class LPChatBarView: UIView {

    var keybordType: ChatKeyboardType! {
        didSet {
            switch keybordType {
            case .emoj:
                self.recordBtn.isHidden = true
                self.inputTextView.isHidden = false
                
                self.voiceBtn.isSelected = false
                self.moreBtn.isSelected = false
                
                keyBoardDelegate?.chatBarSelectEmojBtn()
                if currentHeight != kChatBarOriginHeight {
                    keyBoardDelegate?.chatBarUpdateHeight(height: currentHeight)
                }
                
            case .text:
                self.recordBtn.isHidden = true
                self.inputTextView.isHidden = false
                
                self.emojBtn.isSelected = false
                self.voiceBtn.isSelected = false
                self.moreBtn.isSelected = false
                
                keyBoardDelegate?.chatBarSelectText()
                if currentHeight != kChatBarOriginHeight {
                    keyBoardDelegate?.chatBarUpdateHeight(height: currentHeight)
                }

            case .voice:
                self.recordBtn.isHidden = false
                self.inputTextView.isHidden = true
                
                self.emojBtn.isSelected = false
                self.moreBtn.isSelected = false
                
                keyBoardDelegate?.chatBarSelectVoiceBtn()
                if currentHeight != kChatBarOriginHeight {
                    keyBoardDelegate?.chatBarUpdateHeight(height: kChatBarOriginHeight)
                }
            case .more:
                self.inputTextView.isHidden = false
                self.recordBtn.isHidden = true
                
                self.voiceBtn.isSelected = false
                self.emojBtn.isSelected = false
                
                keyBoardDelegate?.chatBarSelectMoreBtn()
                if currentHeight != kChatBarOriginHeight {
                    keyBoardDelegate?.chatBarUpdateHeight(height: currentHeight)
                }

            case .normal:
                self.recordBtn.isHidden = true
                self.inputTextView.isHidden = false
        
                voiceBtn.isSelected = false
                emojBtn.isSelected = false
                moreBtn.isSelected = false
                
                keyBoardDelegate?.chatBarUpdateHeight(height: kChatBarOriginHeight)
            default:
                print(keybordType)
            }
            self.emojBtn.setEomjImg()
            self.voiceBtn.setVoiceImg()
        }
    }
    
    weak var keyBoardDelegate: ChatKeyboardDelegate?

    fileprivate var currentHeight: CGFloat = kChatBarOriginHeight
    
    fileprivate lazy var voiceBtn: KeyboardBtn = {
        return self.obtaionBtn(aImg: #imageLiteral(resourceName: "ToolViewInputVoice"), bImg: #imageLiteral(resourceName: "ToolViewInputVoiceHL"))
    }()
    
    fileprivate lazy var emojBtn: KeyboardBtn = {
        return self.obtaionBtn(aImg: #imageLiteral(resourceName: "ToolViewEmotion"), bImg: #imageLiteral(resourceName: "ToolViewEmotionHL"))
    }()
    
    fileprivate lazy var moreBtn: KeyboardBtn = {
        return self.obtaionBtn(aImg: #imageLiteral(resourceName: "ToolViewAdd"), bImg: #imageLiteral(resourceName: "ToolViewAddHL"))
    }()
    
    fileprivate lazy var recordBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("按住 说话", for: .normal)
        btn.setTitle("松开 结束", for: .highlighted)
        btn.setBackgroundImage(RGBA(r: 0.7, g: 0.7, b: 0.7, a: 0.5).transImage(), for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.isHidden = true
        btn.setTitleColor(RGBA(r: 0.3, g: 0.3, b: 0.3, a: 1.0), for: .normal)
        btn.layer.cornerRadius = 4.0
        btn.layer.masksToBounds = true
        btn.layer.borderColor = kSplitLineColor.cgColor
        btn.layer.borderWidth = 0.5
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
    }
}


extension LPChatBarView {
    @objc fileprivate func chatBarBtnSelect(_ btn: UIButton) -> Void {
        btn.isSelected = !btn.isSelected
        btn.isSelected ? resignResponder() : becomeResponder()
        if btn == voiceBtn {
            keybordType = btn.isSelected ? .voice : .text
        } else if btn == emojBtn {
            keybordType = btn.isSelected ? .emoj : .text
        } else {
            keybordType = btn.isSelected ? .more : .text
        }
    }
    @objc fileprivate func recordBtnDown() -> Void {
        keyBoardDelegate?.chatBarStopRecord()
    }
    
    @objc fileprivate func recordBtnUpInside() -> Void {
        keyBoardDelegate?.chatBarStopRecord()
    }
    
    @objc fileprivate func recordBtnUpOutSide() -> Void {
        keyBoardDelegate?.chatBarCancelRecord()
    }
    
    @objc fileprivate func recordBtnDragOutSide() -> Void {
        keyBoardDelegate?.chatBarDragInside(inside: false)
    }
    
    @objc fileprivate func recordBtnDragInSide() -> Void {
        keyBoardDelegate?.chatBarDragInside(inside: true)
    }
    
    override func resignFirstResponder() -> Bool {
        self.inputTextView.resignFirstResponder()
        keybordType = .normal
        return super.resignFirstResponder()
    }
    
    func becomeResponder() -> Void {
        self.inputTextView.becomeFirstResponder()
    }
    
    func resignResponder() -> Void {
        if inputTextView.isFirstResponder {
             self.inputTextView.resignFirstResponder()
        }
    }
    

}

extension LPChatBarView {
    fileprivate func obtaionBtn(aImg: UIImage,bImg: UIImage) -> KeyboardBtn {
        let btn = KeyboardBtn.creatBtn()
        btn.setImg(aImg: aImg, bImg: bImg)
        btn.addTarget(self, action: #selector(chatBarBtnSelect(_ :)), for: .touchUpInside)
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
            make.top.equalTo(self.snp.top).offset(7)
            make.bottom.equalTo(self.snp.bottom).offset(-7)
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
        
        var fixH = textView.sizeThatFits(textView.size).height
        fixH = fixH > kTextViewMinHeight ? fixH : kTextViewMinHeight
        fixH = fixH < kTextViewMaxHeight ? fixH : kTextViewMaxHeight
        currentHeight = fixH + kChatBarOriginHeight - kTextViewMinHeight
      
        if currentHeight != textView.height {
            UIView.animate(withDuration: 0.05, animations: {
                self.keyBoardDelegate?.chatBarUpdateHeight(height: self.currentHeight)
            })
        }
        textView.scrollToBottom(animated: false)
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byCharWrapping
        let attr = [NSAttributedStringKey.paragraphStyle: paraStyle, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        textView.attributedText = NSAttributedString(string: textView.text, attributes: attr)
        let str = textView.text as NSString
        textView.scrollRangeToVisible(NSMakeRange( str.length, 1))
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        keybordType = .text
    }
    
}


