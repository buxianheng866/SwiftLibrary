//
//  DownloadController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/3.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import AVKit
class DownloadController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var downloadData = [DownloadViedoModel]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.register(UINib(nibName: "DownloadCell", bundle: nil), forCellReuseIdentifier: "DownloadInformation")
        getDatalist()
    }

    @IBAction func downloadAction(_ sender: Any) {
        let urlStr = textView.text
        guard let object = urlStr else { return }
        if object.isEmpty {
            printLog("空字符串")
            return
        }
        
        if object.hasPrefix("https://") {
            download(object).response(completion: { [weak self] (result) in
                switch result {
                case .success:
                    HUDView.showSuccess(withStatus: "下载成功")
                    self?.getDatalist()
                default:
                    HUDView.showError(withStatus: "下载失败")
                }
            })
        } else {
            HUDView.showInfo(withStatus: "url不对")
        }
    }
    
    func getDatalist() {
        downloadData.removeAll()
        let dict = DownloadManager.default.allDownloadFilePath()
        for (key , value) in dict {
            let model = DownloadViedoModel()
            model.filePath = key as? String
            model.filename = value as? String
            downloadData.append(model)
        }
        self.tableView.reloadData()
    }
    
    func playMusic(model: DownloadViedoModel) -> Void {
        
        let url = downloadFilePath(model.filePath!)
        guard let urlStr = url else {
            return
        }
        do {
//            let player = try! AVAudioPlayer(contentsOf: urlStr)
//            player.prepareToPlay()
            let playerController = AVPlayerViewController()
            let player = AVPlayer(url: urlStr)
            playerController.player = player
            self.present(playerController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
extension DownloadController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadInformation") as! DownloadCell
        cell.model = downloadData[indexPath.row]
        cell.downloadCellBlock = { [weak self] md in
           self?.playMusic(model: md)
        }
        cell.deleteCellBlock = { [weak self] in
            self?.getDatalist()
        }
        return cell
    }
}

extension DownloadController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return true
        }
        return false
    }
}

class DownloadViedoModel {
    var filename: String?
    var filePath: String?
}

