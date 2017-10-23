//
//  LPDownloadView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/20.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
class LPDownloadView: UIView {

    @IBOutlet weak var prolab: UILabel!
    @IBOutlet weak var proView: UIProgressView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    class func newInstance() -> LPDownloadView? {
        let nib = Bundle.main.loadNibNamed( String(describing: self), owner: nil, options: nil)
        guard let nibView = nib?.first as? LPDownloadView else { return nil }
        return nibView
    }
    
    let vedioURL = "http://120.25.226.186:32812/resources/videos/minion_12.mp4"

    
    func updateUI() -> Void {
        let status = downloadStatus(vedioURL)
        let progre = downloadPercent(vedioURL)
        leftBtn.setTitle(buttonStatus(status), for: .normal)
        proView.progress = Float(progre)
        prolab.text = "\((progre))"
        rightBtn.isEnabled = progre == 0 ? false : true
    }
    
    func buttonStatus(_ status: DownloadStatus) -> String {
        switch status {
        case .suspend:
            return "开始"
        case .complete:
            return "播放"
        case .downloading:
            return "暂停"
        case .normal:
            return "正常"
        case .fail:
            return "失败"
        }
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        let downStatus = downloadStatus(vedioURL)
        switch downStatus {
        case .complete:
            let fileUrl = downloadFilePath(vedioURL)
            printLog("地址: \(fileUrl!)")
            
//            let fileURL = cacheDirectory().appendingPathComponent("\(downloadFolder)/minion_12.mp4")
//            let playerController = AVPlayerViewController()
//            let player = AVPlayer(url: fileURL)
//            playerController.player = player
//            self.present(playerController, animated: true, completion: nil)
            
        case .downloading:
            downloadCancel(vedioURL)
        case .suspend:
            download(vedioURL).downloadProgress(progress: { [weak self] _ in
                self?.updateUI()
            }).response(completion: { [weak self] data in
                self?.updateUI()
                printLog(data)
            })
        default:
            printLog("default")
        }
        
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        downloadDelete(vedioURL)
        self.updateUI()
    }
    
}
