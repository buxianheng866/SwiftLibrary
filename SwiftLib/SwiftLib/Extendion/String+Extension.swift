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
    
    func MD5String() -> String {
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    //size
    func textSize(maxSize: CGSize = CGSize(width: mScreenW, height: 1000),font: UIFont = UIFont.systemFont(ofSize: kGenalTextFont)) -> CGSize {
        let str = self as NSString
        let gSize = str.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size
        return gSize
    }
    
}

