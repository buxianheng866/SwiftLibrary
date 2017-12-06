//
//  LogInViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/12/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var account: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func logIn(_ sender: Any) {
        IMManager.default.userLog(account: self.account.text!, password: self.password.text!) { (reslut) in
            if reslut == true {
                let conver = ConversationController()
                self.navigationController?.pushViewController(conver, animated: true)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.account.resignFirstResponder()
        self.password.resignFirstResponder()
    }

}
