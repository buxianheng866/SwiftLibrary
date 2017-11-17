//
//  LPChatViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class LPChatViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cellcell")
        return tab
    }()
    lazy var keyboard: LPChatKeyboard = {
        let key = LPChatKeyboard()
        key.keyboardDelegate = self
        key.controller = self
        key.aboveView = self.tableView
        return key
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var message = "whos your daddy"
    
}

extension LPChatViewController {
    func setUI() -> Void {
        self.view.addSubview(keyboard)
        self.view.addSubview(tableView)
        keyboard.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(kCustomKeyboardViewHeight)
            make.height.equalTo(kOriginKeyboardHeight)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(keyboard.snp.top)
        }
    
    }
}

extension LPChatViewController {
    func scrollToBottom(animatied: Bool = false) -> Void {
        self.view.layoutIfNeeded()
        let indexPath = IndexPath(row: 19, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: animatied)
    }
}


extension LPChatViewController: LPChatKeyboradDelegate {
    func sendMessage(messg: String) {
        message = messg
       self.tableView.reloadData()
        printLog("message: \(messg)")
        
        self.scrollToBottom()
    }
}

extension LPChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcell", for: indexPath)
        
        let attr = LPEmotionHelper.findAttrStr(text: message, font: UIFont.systemFont(ofSize: 15))
        
        cell.textLabel?.attributedText = attr!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = self.keyboard.resignFirstResponder()
    }
    
}

