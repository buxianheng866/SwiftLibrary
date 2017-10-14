//
//  ViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var xibView: XibNormalView = {
        guard let xib = XibNormalView.newInstance() else {
            return XibNormalView()
        }
        return xib
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xibView.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        
        self.view.addSubview(xibView)
    }
    
    @IBAction func selectedAct(_ sender: Any) {
        
        LPPhotoHelper.open(.photoLibrary).showSelectedImage { (data) in
            print("showshow")
        }
    }
    
}




