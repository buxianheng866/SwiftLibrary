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




let mScreenH = UIScreen.main.bounds.height

let mScreenW = UIScreen.main.bounds.width

let kSafeAreaInset = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero


let isPhoneX = UIScreen.main.currentMode?.size.height == 2436

let kNavBarColor = UIColor.orange

let kApplication = UIApplication.shared



let kGenalTextFont: CGFloat = 15







