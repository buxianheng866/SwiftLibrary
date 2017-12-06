//
//  ChatViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatViewController: UIViewController {
    
    init(session: NIMSession) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = session.sessionId
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        printLog("聊天页面销毁了")
    }
    
    lazy var collectView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collect.delegate = self
        collect.backgroundColor = UIColor.white
        collect.dataSource = self
        collect.register(ChatBaseCell.self, forCellWithReuseIdentifier: "cellcell")
        return collect
    }()
    
    lazy var keyboard: LPChatKeyboard = {
        let key = LPChatKeyboard()
        key.keyboardDelegate = self
        key.controller = self
        return key
    }()
}

extension ChatViewController {
    private func setUI() -> Void {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(keyboard)
        self.view.addSubview(collectView)
        keyboard.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(kCustomKeyboardViewHeight)
            make.height.equalTo(kOriginKeyboardHeight)
        }
        
        collectView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(keyboard.snp.top)
        }
        
    }
    
    open func scrollToBottom(animated: Bool = false) -> Void {
        guard let data = ChatMsgManager.default.messageSource else { return }
        let index = IndexPath(item: data.count - 1, section: 0)
        self.collectView.scrollToItem(at: index, at: .top, animated: animated)
    }
}





