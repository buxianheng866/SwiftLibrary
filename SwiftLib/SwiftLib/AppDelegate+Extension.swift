//
//  AppDelegate+Extension.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/30.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
// MARK: NIMSDK相关
extension AppDelegate {
    func registerIMSDK() -> Void {
//        let option = NIMSDKOption.init(appKey: IMappKey)
        NIMSDK.shared().register(withAppID: IMappKey, cerName: nil)
    }
}
