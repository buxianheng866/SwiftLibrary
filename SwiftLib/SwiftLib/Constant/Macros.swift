//
//  Macros.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import UIKit

enum newNumber: Int {
    case one = 3, two, three, four

    var which: Int {
        switch self {
        case .one:
            return 10
        default:
            return 20
        }
    }
}

func printLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) -> Void {
    #if DEBUG
//        let fileN = (file as NSString).lastPathComponent
        print("(line: \(lineNum))->\(funcName)---\(message)")
    
    #endif
}



let kNavBarColor = UIColor.orange

let mScreenH = UIScreen.main.bounds.height

let mScreenW = UIScreen.main.bounds.width

let statusBarFrame = UIApplication.shared.statusBarFrame

let kSafeAreaInset = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero

let isPhoneX = UIScreen.main.currentMode?.size.height == 2436

let TopBarHeight = isPhoneX ? 88 : 64

let BottomBarHeight = isPhoneX ? 83 : 49 //底部有tabbar高度

let StatusBarHeight = isPhoneX ? 44 : 20 //状态栏高度

let kApplication = UIApplication.shared

let kGenalTextFont: CGFloat = 15

// MARK:- 颜色方法
func normalRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r, green: g, blue: b, alpha: a)
}





