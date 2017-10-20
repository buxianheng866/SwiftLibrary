//
//  ViewController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import AVKit
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
//        /Users/nb616/Library/Developer/CoreSimulator/Devices/4D28844D-6C07-4C9C-883C-B37560B7BFB4/data/Containers/Data/Application/2BA5A86D-C42F-4BCC-A924-0A0E1671257B/Library/Caches/Download/minion_12.mp4
       printLog(homePath)
        
    }
    
    @IBAction func selectedAct(_ sender: Any) {
        
//        LPPhotoHelper.open(.photoLibrary).showSelectedImage { (data) in
//            print("showshow")
//        }
        
     
        let fileURL = cacheDirectory().appendingPathComponent("\(downloadFolder)/minion_12.mp4")
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: fileURL)
        playerController.player = player
        self.present(playerController, animated: true, completion: nil)
        
        
    }
    
}




