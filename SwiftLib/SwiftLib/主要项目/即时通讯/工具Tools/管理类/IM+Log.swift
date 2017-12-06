//
//  IM+Log.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

extension IMManager {
    
    /** 用户手动登录*/
    func userLog(account: String,password: String,result: @escaping (Bool)->()) -> Void {
        NIMSDK.shared().loginManager.login(account, token: password) { [weak self] error in
            if let err = error {
                printLog("登录失败: \(err)")
                HUDView.showError(withStatus: "登录失败")
                result(false)
            } else {
                HUDView.showSuccess(withStatus: "登录成功")
                self?.saveUserAccount(account: account, password: password)
                result(true)
            }
        }
       
    }
    
    /** 自动登录*/
    func autoLog() -> Void {
        
        let object = UserDefaults.standard.object(forKey: U_UserAccount) as? [String : String]
        if let sb = object {
            NIMSDK.shared().loginManager.autoLogin(sb[U_UserAccount]!, token: sb[U_UserPassWord]!)
        } else {
            HUDView.showError(withStatus: "自动登录失败")
        }
    }
    
    /** 登出*/
    func logOut() -> Void {
        NIMSDK.shared().loginManager.logout { err in
            if let e = err {
                //todo:
                HUDView.showError(withStatus: "登出失败:\(e)")
            }
        }
    }
    
    /** 当前登录账号*/
    func currentAccount() -> String {
        return NIMSDK.shared().loginManager.currentAccount()
    }
    /** 当前登录状态*/
    func isLogined() -> Bool {
        return NIMSDK.shared().loginManager.isLogined()
    }
    
}

extension IMManager: NIMLoginManagerDelegate {
    
    /** 被踢回调*/
    func onKick(_ code: NIMKickReason, clientType: NIMLoginClientType) {
        switch code {
        case .byClient:
            HUDView.showError(withStatus: "被另外一个客户端踢下线")
        case .byServer:
            HUDView.showError(withStatus: "被服务器踢下线")
        case .byClientManually:
            HUDView.showError(withStatus: "被另外一个客户端手动选择踢下线")
        }
    }
    
    /** 自动登录失败回调*/
    func onAutoLoginFailed(_ error: Error) {
        HUDView.showError(withStatus: "自动登录失败")
    }
}

//MARK: 私有方法
extension IMManager {
    
    fileprivate func saveUserAccount(account: String, password: String) {
        UserDefaults.standard.set([U_UserAccount: account,U_UserPassWord: password], forKey: U_UserAccount)
    }
}

