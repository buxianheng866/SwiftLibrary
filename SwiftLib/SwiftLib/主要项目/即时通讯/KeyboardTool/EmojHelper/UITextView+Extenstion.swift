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
        let attachment = EmotionAttachment()
        attachment.text = emotion.text
        attachment.image = UIImage(contentsOfFile: emotion.imgPath!)
        let font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        
        let attrStr = NSMutableAttributedString(attributedString: attributedText)
        let range = selectedRange
        attrStr.replaceCharacters(in: range, with: attrImageStr)
        self.attributedText = attrStr
        self.font = font
        self.selectedRange = NSMakeRange(range.location + 1, 0)
    }
}
