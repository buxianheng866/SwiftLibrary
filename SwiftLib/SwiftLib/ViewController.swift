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
    

    func ios11Later() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            print(self.view.safeAreaInsets)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func selectedAct(_ sender: Any) {
        let chat = LPChatViewController()
        self.navigationController?.pushViewController(chat, animated: true)
    }
    
    @IBAction func godownload(_ sender: Any) {
        let download = DownloadController()
        self.navigationController?.pushViewController(download, animated: true)
        
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




