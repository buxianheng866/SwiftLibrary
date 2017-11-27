//
//  UITextView+Extenstion.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/31.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
extension UITextView {
    // 获取textView属性字符串.换成对应的字符串
    func getEmotionString() -> String {
        let attrStr = NSMutableAttributedString(attributedString: attributedText)
        let range = NSMakeRange(0, attrStr.length)
        attrStr.enumerateAttributes(in: range, options: []) { (dict, ran, _) in
            if let attachment = dict[NSAttributedStringKey.attachment] as? EmotionAttachment {
                attrStr.replaceCharacters(in: range, with: attachment.text!)
            }
        }
        return attrStr.string
    }
    
    func insertEmotion(emotion: LPEmotion) -> Void {
        if emotion.isEmpty {
            return
        }
        if emotion.isRemove {
            deleteBackward()
            return
        }
        // 创建附件
        let attachment = EmotionAttachment()
        attachment.text = emotion.face_name
        // 设置图片
        attachment.image = UIImage(named: emotion.face_name)
        let font = self.font!
        // 设置附件大小 表情根文本打大小一致
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        
        let attrStr = NSMutableAttributedString(attributedString: attributedText)
        let range = selectedRange
        attrStr.replaceCharacters(in: range, with: attrImageStr)
        self.attributedText = attrStr
        self.font = font
        self.selectedRange = NSMakeRange(range.location + 1, 0)
    }
    
    
    private func deleteback(range: NSRange) {
        let str = self.text as NSString
        let isLength = range.location + range.length <= str.length
        if isLength && range.length != 0 {
            let newtext = str.replacingCharacters(in: range, with: "")
            let newRange = NSMakeRange(range.location, 0)
            self.text = newtext
            self.selectedRange = newRange
        }
    }
    
    private func rangeFrom(pre: String, suf: String) -> NSRange {
        let range = self.selectedRange
        let str = self.text as NSString
        let selectStr = (range.length > 0 ? str.substring(with: range) : str as String) as NSString
        let endLoc = range.location
        var index = -1
        if endLoc > 0 {
            if selectStr.hasSuffix(suf) {
                let p = 20
                
                for item in (0...endLoc).reversed() {
                    if item - 1 >= 0 && item >= endLoc - p {
                        let subRange = NSMakeRange(item - 1, 1)
                        let substring = str.substring(with: subRange) as NSString
                        if substring.compare(pre) == .orderedSame {
                            index = item - 1
                            break
                        }
                    }
                }
            }
        }
        return index == -1 ? NSMakeRange(endLoc - 1, 1) : NSMakeRange(index, endLoc - index)
    }
    
    func deleteText(isEmo: Bool,change: (() -> Void)?) -> Bool {
        let range = self.rangeFrom(pre: "[", suf: "]")
        if range.length == 1 {
            if isEmo {
                self.deleteBackward()
            }
            return true
        }
        self.deleteback(range: range)
        if change != nil {
            change!()
        }
        return false
    }
    
}

/*
extension String {
    subscript (r: Range<Int>) -> String {
        mutating get {
            let index: String.Index = self.index(after: self.startIndex)
            self = self.substring(from: index)

        }
    }
}
*/
