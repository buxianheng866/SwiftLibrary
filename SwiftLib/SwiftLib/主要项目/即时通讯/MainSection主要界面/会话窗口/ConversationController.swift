//
//  ConversationController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/12/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class ConversationController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: mScreenW, height: mScreenH - TopBarHeight - BottomBarHeight))
        let nib = UINib(nibName: "ConversationCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "cellcell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    var session: NIMSession! {
        let acount = IMManager.default.currentAccount() == "bxh001" ? "bxh002" : "bxh001"
        let ss = NIMSession(acount, type: .P2P)
        return ss
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ConversationController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcell", for: indexPath) as! ConversationCell
        cell.nameLab.text  = session?.sessionId
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController(session: session!)
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
}
