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
        attachment.text = emotion.text
        // 设置图片
        attachment.image = UIImage(contentsOfFile: emotion.imgPath!)
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
}
/*
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
        ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs  1) {
        const unichar ls = [substring characterAtIndex:1];
        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
        if (0x1d000 <= uc && uc  1) {
        const unichar ls = [substring characterAtIndex:1];
        if (ls == 0x20e3) {
        returnValue = YES;
        }
        
        } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
        returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
        returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
        returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
        returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
        returnValue = YES;
        }
        }
        }];
        
        return returnValue;
}*/
