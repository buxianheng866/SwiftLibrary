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
    
    let downloadUrl = "http://120.25.226.186:32812/resources/videos/minion_12.mp4"

    
    func updateUI() -> Void {
        let status = downloadStatus(downloadUrl)
        let progre = downloadPercent(downloadUrl)
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
        let downStatus = downloadStatus(downloadUrl)
        switch downStatus {
        case .complete:
            let fileUrl = downloadFilePath(downloadUrl)
            printLog("地址: \(fileUrl!)")
        case .downloading:
            downloadCancel(downloadUrl)
        case .suspend:
            download(downloadUrl).downloadProgress(progress: { [weak self] _ in
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
        downloadDelete(downloadUrl)
        self.updateUI()
    }
    
}
