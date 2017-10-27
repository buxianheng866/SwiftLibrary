//
//  LPPlayerController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
//import IJKMediaFramework
class LPPlayerController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    var liveMD: ViewListModel!
    
//    var ijkPlay: IJKFFMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//        setPlayer()
//        addMovieNotification()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
//        if ijkPlay != nil {
//            ijkPlay.pause()
//            ijkPlay.stop()
//            ijkPlay.shutdown()
//        }
       
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
/*
extension LPPlayerController {
    
    func setPlayer() -> () {
        ijkPlay = IJKFFMoviePlayerController(contentURLString: liveMD.shareAddr!, with: nil)
        ijkPlay.view.frame = UIScreen.main.bounds
        ijkPlay.scalingMode = .aspectFit
        self.view.addSubview(ijkPlay.view)
        self.view.bringSubview(toFront: backBtn)
        ijkPlay.prepareToPlay()
        
    }
    
    func addMovieNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(loadStateDidChange(_:)), name: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moviePlayBackDidFinish(_:)), name: NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(mediaIsPreparedToPlayDidChange(_:)), name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moviePlayBackStateDidChange(_:)), name: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange, object: nil)
        
    }
    
    
    @objc func loadStateDidChange(_ noti: Notification) -> Void {
        printLog("state---->\(ijkPlay.loadState)")
        
    }
    @objc func moviePlayBackDidFinish(_ noti: Notification) -> Void {
        let x = noti.userInfo!["IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey"] as! Int
        let reason: IJKMPMovieFinishReason = IJKMPMovieFinishReason(rawValue: x)!
        switch reason {
        case .playbackEnded:
            printLog("播放结束:\(reason)")
        case .playbackError:
            printLog("播放错误:\(reason)")
        case .userExited:
            printLog("用户退出:\(reason)")
        }
    }
    @objc func mediaIsPreparedToPlayDidChange(_ noti: Notification) -> Void {
        printLog("准备去播放改变")
    }
    @objc func moviePlayBackStateDidChange(_ noti: Notification) -> Void {
        printLog("playback:\(ijkPlay.playbackRate)")
    }
 
    
}
  */
