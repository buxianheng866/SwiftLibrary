//
//  LPBaseViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/13.
//  Copyright © 2017年 nb616. All rights reserved.
//
import Foundation
import UIKit
class LPBaseViewController: UIViewController {
    lazy var tableView: UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
            self.tableView.estimatedRowHeight = 0;
            self.tableView.estimatedSectionHeaderHeight = 0;
            self.tableView.estimatedSectionFooterHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        
       
    }
    
}
