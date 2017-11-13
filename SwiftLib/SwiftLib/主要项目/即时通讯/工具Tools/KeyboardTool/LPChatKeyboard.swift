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
        bar.keyBoardDelegate = self
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
    
    deinit {
        printLog("keyBoard被销毁了")
        NotificationCenter.default.removeObserver(self)
    }
}

extension LPChatKeyboard {
    
    private func setUI() -> Void {
        self.addSubview(emojView)
        self.addSubview(moreView)
        self.addSubview(chatBar)
        
        chatBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kChatBarOriginHeight)
        }
        
        emojView.snp.makeConstraints { (make) in
            make.top.equalTo(chatBar.snp.bottom).offset(kSafeAreaInset.bottom)
            make.left.right.bottom.equalTo(0)
        }
    }
    
    private func addNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardShow(_ notif: Notification) -> Void {
        
        let keyboardFrame = notif.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        printLog(keyboardFrame)
        
        
    }
    
    @objc private func keyboardHide(_ notif: Notification) -> Void {
        
    }
    
    
}


extension LPChatKeyboard: ChatKeyboardDelegate {
    // 发送消息
    func chatKeyBoardSendMessage(message: String) {
        
    }
    // 更新高度
    func chatBarUpdateHeight(height: CGFloat) {
        if height != chatBar.height {
            chatBar.snp.updateConstraints { (make) in
                make.height.equalTo(height)
            }
            self.snp.updateConstraints { (make) in
                make.height.equalTo(height + kCustomKeyboardViewHeight)
            }
            UIView.animate(withDuration: keyboardDuration) {
                self.controller.view.layoutIfNeeded()
            }
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
    
    // 点击按钮
    func chatBarSelectMoreBtn() {
        
    }
    func chatBarSelectEmojBtn() {
        
    }
    func chatBarSelectVoiceBtn() {
        
    }
    func chatBarSelectText() {
        
    }
}

