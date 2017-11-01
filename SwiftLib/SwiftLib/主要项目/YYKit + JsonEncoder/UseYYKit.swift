//
//  UseYYKit.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/1.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import UIKit
import YYKit
class UseYYabel {
   
    
    func obtainYYLabel() -> YYLabel {
        let lab = YYLabel()
        lab.displaysAsynchronously = true //打开异步渲染
        lab.numberOfLines = 0
        lab.preferredMaxLayoutWidth = mScreenW - 30
       
        
        let attr = self.getAttr(text: "无法拒绝阿斯蒂芬发生八点上发布把速度播放大部分卡低分辨卡迪夫把绝地反击巴德富啊京东方八点积分把就看订房间大部分吧看大部分回家把多好覅阿发达不八宝饭四点半不对吧发速度播放阿宝无法拒绝阿斯蒂芬发生八点上发布把速度播放大部分卡低分辨卡迪夫把绝地反击巴德富啊京东方八点积分把就看订房间大部分吧看大部分回家把多好覅阿发达不八宝饭四点")
        let maxsize = CGSize(width: mScreenW - 36, height: CGFloat.greatestFiniteMagnitude)
        
        let titlelayout = YYTextLayout(containerSize: maxsize, text: attr)
        
        let titleHeight = titlelayout?.textBoundingSize.height
        lab.attributedText = attr
        lab.frame = CGRect(x: 50, y: 200, width: mScreenW - 30, height: titleHeight!)
        return lab
    }
    
    func getAttr(text: String) -> NSMutableAttributedString {
        let resultAttr = NSMutableAttributedString(string: text)
        resultAttr.alignment = .justified
        resultAttr.lineSpacing = 5
        resultAttr.font = UIFont.systemFont(ofSize: 10)
        resultAttr.setFont(UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, 5))
        resultAttr.kern = NSNumber(value: 1.0)
        return resultAttr
    }
    
}

class LPTagView: YYLabel {
    struct TagMaker {
        var strokeWidth: CGFloat = 1
        var strokeColor = UIColor.orange
        var fillColor = UIColor.clear
        var cornerRadius: CGFloat = 100
        var insets = UIEdgeInsets(top: -2, left: -6, bottom: -2, right: -6)
        var font = UIFont.systemFont(ofSize: 15)
        var textColor = UIColor.black
        var lineSpace: CGFloat = 10
        var maxwidth = mScreenW - 20
        var tagAlignment: NSTextAlignment = .left
    }
    
    var maker = TagMaker()
    
    let tags = ["调情发","哈哈个","gggas","发打扫房间as","发图哈给他","俺家换地方接口","回复回复","哈哈","啊","h","大卫","芬爱打架发哦就","推推回个话"]
    
    class func obatainAttributed(_ callMaker: (TagMaker) -> ()) -> LPTagView {
        let taglab = LPTagView()
        taglab.numberOfLines = 0
        let attribut = NSMutableAttributedString()
        callMaker(taglab.maker)
        var labHeight: CGFloat = 0
        for (i , item) in taglab.tags.enumerated() {
            let tagText = NSMutableAttributedString(string: item)
            tagText.insertString("   ", at: 0)
            tagText.appendString("   ")
            tagText.font = taglab.maker.font
            tagText.color = taglab.maker.textColor
            let binding = YYTextBinding(deleteConfirm: false)
            tagText.setTextBinding(binding, range: tagText.rangeOfAll())
            
            //item样式
            let border = YYTextBorder()
            border.strokeColor = taglab.maker.strokeColor
            border.strokeWidth = taglab.maker.strokeWidth
            border.fillColor = taglab.maker.fillColor
            border.cornerRadius = taglab.maker.cornerRadius
            border.insets = taglab.maker.insets
            let range = tagText.string as NSString
            tagText.setTextBackgroundBorder(border, range: range.range(of: item))
            
            attribut.lineSpacing = taglab.maker.lineSpace
            attribut.lineBreakMode = .byWordWrapping
            attribut.append(tagText)
        
            let maxSize = CGSize(width: taglab.maker.maxwidth, height: CGFloat.greatestFiniteMagnitude)
            let layout = YYTextLayout(containerSize: maxSize, text: attribut)
            if (layout?.textBoundingSize.height)! > labHeight {
                if i != 0 {
                    attribut.insertString("\n", at: UInt(attribut.length - tagText.length))
                }
                labHeight = (layout?.textBoundingSize.height)!
            }
        }
       
        let style = NSMutableParagraphStyle()
        style.lineSpacing = taglab.maker.lineSpace
        style.alignment = .left
        attribut.addAttribute( NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, attribut.length))
        taglab.attributedText = attribut
        taglab.frame = CGRect(x: 0, y: 200, width: taglab.maker.maxwidth, height: labHeight + taglab.maker.lineSpace)
        return taglab
    }
    
    
    
    
    
    
    
}

