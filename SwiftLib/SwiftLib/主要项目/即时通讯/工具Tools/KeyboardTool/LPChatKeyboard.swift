//
//  LPChatKeyboard.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/10.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit


class LPChatKeyboard: UIView {
    
    weak var controller: UIViewController!
    weak var aboveView: UIView!
    weak var keyboardDelegate: LPChatKeyboradDelegate?

    lazy var chatBar: LPChatBarView = {
        let bar = LPChatBarView()
        bar.chatBarDelegate = self
        return bar
    }()
    
    lazy var moreView: LPKeyboardMoreView = {
        let more = LPKeyboardMoreView()
        return more
    }()
    
    lazy var emojView: LPEmotionView = {
        let emoj = LPEmotionView()
        return emoj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addNotification()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() -> Void {
        self.addSubview(chatBar)
        self.addSubview(emojView)
        self.addSubview(moreView)
        
        chatBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kChatBarOriginHeight)
        }
        
        emojView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(kCustomKeyboardViewHeight)
        }
        
        moreView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(kCustomKeyboardViewHeight)
        }
        
        emojView.selectEmotionBlock = {
           [weak self] model in
            if model.isRemove {
                let _ = self?.chatBar.inputTextView.onTextDeleteisEmo(true, block: {
                    self?.chatBar.textViewDidChange((self?.chatBar.inputTextView)!)
                })
                
            } else {
               self?.chatBar.inputTextView.insertText(model.text!)
            }
        }
        
        emojView.selectSendBlock = { [weak self] in
            printLog("发送")
            self?.chatBarSendMessage()
        }
    }
    
    deinit {
        printLog("keyBoard被销毁了")
        NotificationCenter.default.removeObserver(self)
    }
    override func resignFirstResponder() -> Bool {
        let _ = chatBar.resignFirstResponder()
        return super.resignFirstResponder()
    }
}

extension LPChatKeyboard {
    
    private func addNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardShow(_ notif: Notification) -> Void {
        customKeyboardInintConstraints()
        let keyboardFrame = notif.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let duration = notif.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let mH = kCustomKeyboardViewHeight + chatBar.currentHeight + keyboardFrame.size.height
        chatBar.snp.updateConstraints { (make) in
            make.height.equalTo(chatBar.currentHeight)
        }
        self.updateMheight(height: mH, duration: duration)
    }
    
    @objc private func keyboardHide(_ notif: Notification) -> Void {
        if chatBar.keybordType == .normal {
            let keyboardFrame = notif.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
            let duration = notif.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
            let mH = self.height - keyboardFrame.size.height + kSafeAreaInset.bottom
            self.updateMheight(height: mH,duration: duration)
        }
    }
    
    private func updateMheight(height: CGFloat,
                               duration: TimeInterval = keyboardDuration,
                               isAnimotion: Bool = true) -> Void {
        self.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        if isAnimotion {
            UIView.animate(withDuration: duration) {
                self.controller.view.layoutIfNeeded()
            }
             (self.controller as! LPChatViewController).scrollToBottom()
        }
    }
    
    private func customKeyboardInintConstraints() -> Void {
        emojView.snp.updateConstraints({ (make) in
            make.bottom.equalTo(0)
        })
        
        moreView.snp.updateConstraints { (make) in
            make.bottom.equalTo(0)
        }
    }
    
    private func showOtherView(other: UIView) -> Void {
        customKeyboardInintConstraints()
        self.snp.updateConstraints { (make) in
            make.height.equalTo(2 * kCustomKeyboardViewHeight + chatBar.height + kSafeAreaInset.bottom)
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.controller.view.layoutIfNeeded()
        }) { (flag) in
            other.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.snp.bottom).offset(-(kCustomKeyboardViewHeight + kSafeAreaInset.bottom))
            })
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
        }
    }
    
    
}


extension LPChatKeyboard: ChatBarDelegate {
    
    // 发送消息
    func chatBarSendMessage() {
        keyboardDelegate?.sendMessage(messg: chatBar.inputTextView.text)
        chatBar.chatBarTextViewRestore()
    }
    // textView变化更新高度
    func chatBarUpdateHeight(height: CGFloat) {
        
        let mH = self.height -  chatBar.height
        if height != chatBar.height {
            chatBar.snp.updateConstraints { (make) in
                make.height.equalTo(height)
            }
            self.updateMheight(height: mH + height)
        }
    }
    // 录音
    func chatBarStartRecord() {
        
    }
    func chatBarStopRecord() {
        
    }
    func chatBarCancelRecord() {
        
    }
    func chatBarDragInside(inside: Bool) {
        
    }
    
    // 点击 +
    func chatBarSelectMoreBtn() {
        showOtherView(other: moreView)
    }
    // 点击Emoj
    func chatBarSelectEmojBtn() {
        showOtherView(other: emojView)
    }
    // 点击 voice
    func chatBarSelectVoiceBtn() {
        customKeyboardInintConstraints()
        if chatBar.height != kChatBarOriginHeight {
            chatBar.snp.updateConstraints { (make) in
                make.height.equalTo(kChatBarOriginHeight)
            }
        }
        self.updateMheight(height: kOriginKeyboardHeight)
    }
    
    // normal状态
    func normalKeyboardState() {
        customKeyboardInintConstraints()
        self.updateMheight(height: chatBar.height + kCustomKeyboardViewHeight + kSafeAreaInset.bottom)
    }
    
   
}

