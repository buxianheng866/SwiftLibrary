//
//  ChatBarHelper.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/22.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
class BarHelper {
    
    class func getAllEmojs() -> [[LPEmotion]] {
        return [getEmoJEmotions(),getCustomEmotions()]
    }
    
    // 获取所有Plist
    private class func getEmoJEmotions() -> [LPEmotion] {
        let plistPath = Bundle.main.path(forResource: "Emoji", ofType: "plist")
        return self.resetEmotionsData(plist: plistPath!)
    }
    
    private class func getCustomEmotions() -> [LPEmotion] {
        let plistPath = Bundle.main.path(forResource: "CustomEmoj", ofType: "plist")
        return self.resetEmotionsData(plist: plistPath!)
    }
    
    fileprivate class func resetEmotionsData(plist: String) -> [LPEmotion] {
        let data = NSArray(contentsOfFile: plist) as! [[String : String]]
        var dataSource = [LPEmotion]()
        var index = 0
        for (_ , item) in data.enumerated() {
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
    
    /** 16进制转换为表情*/
    class func emojInCode(code: String) -> String {
        // 创建一个扫描器,扫描器可以从字符串中提取我们想要的数据
        let scan = Scanner(string: code)
        // 将16进制的转换字符串
        var result: UInt32 = 0
        scan.scanHexInt32(&result)
        let emojStr = Character(UnicodeScalar(result)!)
        return String(emojStr)
    }
    
    
    /** 查找属性字符串的方法*/
    class func findAttrStr(text: String, font: UIFont) -> NSMutableAttributedString? {
        let pattern = "\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]" // 匹配表情
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        let attrMStr = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font: font])
        let resutlts = regex.matches(in: text, options: [], range: NSMakeRange(0, attrMStr.length))
        
        
        for (_, result) in resutlts.enumerated().reversed() {
            
            let emoStr = (text as NSString).substring(with: result.range)
            let attachment = NSTextAttachment()
            
            attachment.image = UIImage(named: emoStr)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImageStr = NSAttributedString(attachment: attachment)
            attrMStr.replaceCharacters(in: result.range, with: attrImageStr)
        }
        return attrMStr
    }
    
    
    class func getAdds() -> [LPAddModel] {
        var data = [LPAddModel]()
        let plist = Bundle.main.path(forResource: "Addbar", ofType: "plist")
        let arr = NSArray(contentsOfFile: plist!) as! [[String: String]]
        
        for item in arr {
            let md = LPAddModel()
            md.setValuesForKeys(item)
            data.append(md)
        }
        return data
    }
    
    
    
}
