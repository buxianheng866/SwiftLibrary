//
//  ViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var xibView: LPDownloadView = {
        guard let xib = LPDownloadView.newInstance() else {
            return LPDownloadView()
        }
        return xib
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xibView.frame = CGRect(x: 0, y: 50, width: mScreenW, height: 200)
        self.view.addSubview(xibView)        
    }
    
    @IBAction func selectedAct(_ sender: Any) {
    
        
    }
    
}




