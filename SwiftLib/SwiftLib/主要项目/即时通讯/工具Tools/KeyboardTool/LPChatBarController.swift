//
//  LPChatBarController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class LPChatBarController: UIViewController {

    lazy var chatBar: LPChatBarView = {
        let chat = LPChatBarView()
        chat.keyBoardDelegate = self
        return chat
    }()
    override func viewDidLoad() {
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension LPChatBarController {
    func setUI() -> Void {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(chatBar)
        
        chatBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(kChatBarOriginHeight)
//            make.bottom.equalTo(self.view.snp.bottom)
            make.top.equalTo(self.view.snp.top).offset(200)
        }
        
    }
}


extension LPChatBarController: ChatKeyboardDelegate {
    func chatKeyBoardSendMessage(message: String) {
        
    }
    
    func chatBarUpdateHeight(height: CGFloat) {
        chatBar.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
}
