//
//  LPEmotionHelper.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/31.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import UIKit
class LPEmotionHelper {
    
    // 获取所有Plist

    
    class func getAllEmotions() -> [LPEmotion] {
        var dataSource = [LPEmotion]()
        let plistPath = Bundle.main.path(forResource: "Expression", ofType: "plist")
        let array = NSArray(contentsOfFile: plistPath!) as! [[String : String]]
        
        var index = 0
        
        for (_ , item) in array.enumerated() {
            dataSource.append(LPEmotion(dict: item))
            index += 1
            if index == 23 {
                dataSource.append(LPEmotion(remove: true))
                index = 0
            }
        }
        dataSource = addEmpty(dataSource: dataSource)
        return dataSource
    }
    
    fileprivate class func addEmpty(dataSource: [LPEmotion]) -> [LPEmotion] {
        var emos = dataSource
        let count = dataSource.count % 24
        if count == 0 {
            return emos
        }
        for _ in count..<23 {
            emos.append(LPEmotion(empty: true))
        }
        emos.append(LPEmotion(remove: true))
        return emos
    }
}

extension LPEmotionHelper {
    // MARK:- 查找属性字符串的方法
    class func findAttrStr(text: String, font: UIFont) -> NSMutableAttributedString? {
        let pattern = "\\[.*?\\]" // 匹配表情
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        let resutlts = regex.matches(in: text, options: [], range: NSMakeRange(0, text.characters.count))
        let attrMStr = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font: font])
        
        for (_, result) in resutlts.enumerated().reversed() {
            
            let emoStr = (text as NSString).substring(with: result.range)
            guard let imgPath = findImgPath(emoStr: emoStr) else {
                return nil
            }
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: imgPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImageStr = NSAttributedString(attachment: attachment)
            attrMStr.replaceCharacters(in: result.range, with: attrImageStr)
        }
        return attrMStr
    }
    
    class func findImgPath(emoStr: String) -> String? {
        for emoj in LPEmotionHelper.getAllEmotions() {
            if emoj.text! == emoStr {
                return emoj.imgPath
            }
        }
        return nil
    }
    
}

