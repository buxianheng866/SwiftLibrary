//
//  IMSDKManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class IMSDKManager {
    static let `default` = IMSDKManager()
    
    let userIMID = {
        return NIMSDK.shared().loginManager.currentAccount()
    }
    
    
    /** 初始化SDK*/
    class func IMint() -> Void {
        NIMSDK.shared().register(withAppID: IMappKey, cerName: nil)
    }
    
}
/** 登录相关*/
extension IMSDKManager {
    /** 自动登录*/
    func autoLogin() -> Bool {
        let tuple = readCurrentUserAccont()
        guard let a = tuple.0, let b = tuple.1 else {
            printLog("登录失败")
            return false
        }
     NIMSDK.shared().loginManager.autoLogin(a, token: b)
     return true
    }
}

/** 私有方法*/
extension IMSDKManager {
    func readCurrentUserAccont() -> (String?, String?) {
        let account = UserDefaults.standard.string(forKey: U_UserAccount)
        let password = UserDefaults.standard.string(forKey: U_UserPassWord)
        return (account,password)
    }
}
