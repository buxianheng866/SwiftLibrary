//
//  String+Extension.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

extension String {
    // 判断是否为字母
    func isAlpha() -> Bool {
        if self == "" {
            return false
        }
        for chr in self.characters {
            let chrStr = chr.description
            if (!(chrStr >= "a" && chrStr <= "z") && !(chrStr >= "A" && chrStr <= "Z") ) {
                printLog("false")
                return false
            }
        }
        printLog("true")
        return true
    }
    
    // 拼音
    func pinyin() -> String {
        let str = NSMutableString(string: self)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        return str.replacingOccurrences(of: " ", with: "")
    }
}

