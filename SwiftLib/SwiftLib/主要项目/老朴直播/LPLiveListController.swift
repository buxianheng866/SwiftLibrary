//
//  LPLiveListController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import SnapKit
class LPLiveListController: LPBaseViewController {
   
//   self.view.safeAreaInsets
    var dataSource = [LiveDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension LPLiveListController {
    func setUI() -> () {
        
        let insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
//        UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
        printLog(insets)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            printLog(insets.bottom)
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, insets.bottom, 0))
        }
        self.tableView.register( UINib(nibName: "LiveListCell", bundle: nil), forCellReuseIdentifier: "livelist")
    }
    
    func loadData() -> Void {
        let time = Date.getStamp()
        let netUrl = "http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=\(time)&auth=9fd94ae57a867116959ac60f0ae5d1fd"
        let param = ["token": "74858010_11_e85e92db03e0d351_2_63009732"]
        //        "http://hlsa.douyucdn.cn/live/%@rpALxOIgvq/playlist.m3u8?wsSecret=193bd3ce3254086baa30086c56b22176&wsTime=%@"
        request(netUrl, method: .post, params: param).jsonResponse { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.getJsonValue(JSON(value))
            default:
                printLog("error")
            }
        }
    }
    
    func getJsonValue(_ json: JSON) -> Void {
        let data = json["data"]
        for (_,b) in data {
            for (_,d) in b["room_list"] {
                let md = LiveDetail()
                md.nickname = d["nickname"].string!
                md.room_src = d["room_src"].string!
                md.room_id = d["room_id"].string!
                md.avatar_small = d["avatar_small"].string!
                dataSource.append(md)
            }
        }
        self.tableView.reloadData()
    }
    
}
extension LPLiveListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "livelist", for: indexPath) as! LiveListCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
}
