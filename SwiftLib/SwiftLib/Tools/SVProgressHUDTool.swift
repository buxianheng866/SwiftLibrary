//
//  SVProgressHUDTool.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/3.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import SVProgressHUD
class HUDView: SVProgressHUD {
    class func initstyle() -> Void {
        self.setBackgroundColor(RGBA(r: 0.0, g: 0.0, b: 0.0, a: 0.7))
        self.setForegroundColor(UIColor.white)
        self.setFont(UIFont.systemFont(ofSize: 14))
        self.setDefaultMaskType(.none)
    }
}

