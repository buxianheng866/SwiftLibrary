//
//  LPLiveListController.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import SnapKit
typealias Model = ViewListModel
class LPLiveListController: LPBaseViewController {
   
//   self.view.safeAreaInsets
    var dataSource = [ViewListModel]()
    
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

        let netUrl = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
        request(netUrl).jsonResponse { [weak self] result in
            switch result {
            case .success(let value):
                self?.getJsonValue(JSON(value))
            default:
                printLog("error")
            }
        }
        
//        request(netUrl, method: .post, params: param).jsonResponse { [weak self] (result) in
//            switch result {
//            case .success(let value):
//                self?.getJsonValue(JSON(value))
//            default:
//                printLog("error")
//            }
//        }
    }
    
    func getJsonValue(_ json: JSON) -> Void {
        let data = json["lives"]
        for item in data.array! {
            dataSource.append(Model(dataDic: item))
        }
        self.tableView.reloadData()
    }
    
}
extension LPLiveListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "livelist", for: indexPath) as! LiveListCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lp = LPPlayerController()
        lp.liveMD = dataSource[indexPath.row]
        self.navigationController?.pushViewController(lp, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1)
        UIView.animate(withDuration: 0.8, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: nil)
    }
    
}
