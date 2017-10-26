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
    
    @IBAction func goStartLive(_ sender: Any) {
        let live = LPLiveStreamController()
        self.navigationController?.pushViewController(live, animated: true)
    }
    
    @IBAction func goSeeLive(_ sender: Any) {
        let list = LPLiveListController()
        self.navigationController?.pushViewController(list, animated: true)
//        self.present(list, animated: true, completion: nil)
    }
}




