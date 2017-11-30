//
//  UIView+Extension.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /*
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var f = self.frame
            f.origin.x = newValue
            self.frame = f
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var f = self.frame
            f.origin.y = newValue
            self.frame = f
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var f = self.frame
            f.size.width = newValue
            self.frame = f
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var f = self.frame
            f.size.height = newValue
            self.frame = f
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    public var rightX: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            var f = self.frame
            f.origin.x = newValue - self.width
            self.frame = f
        }
    }
    
    public var bottomY: CGFloat {
        get {
            return self.y + self.height
        }
        set {
            var f = self.frame
            f.origin.y = newValue - self.height
            self.frame = f
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.centerX, y: newValue)
        }
    }
 */
    
    /**
     依照图片轮廓对控制进行裁剪
     
     - parameter stretchImage:  模子图片
     - parameter stretchInsets: 模子图片的拉伸区域
     */
    func clipShape(stretchImage: UIImage, stretchInsets: UIEdgeInsets) {
        // 绘制 imageView 的 bubble layer
        let bubbleMaskImage = stretchImage.resizableImage(withCapInsets: stretchInsets, resizingMode: .stretch)
        
        // 设置图片的mask layer
        let layer = CALayer()
        layer.contents = bubbleMaskImage.cgImage
        layer.contentsCenter = self.CGRectCenterRectForResizableImage(bubbleMaskImage)
        layer.frame = self.bounds
        layer.contentsScale = UIScreen.main.scale
        layer.opacity = 1
        self.layer.mask = layer
        self.layer.masksToBounds = true
    }
    
    func CGRectCenterRectForResizableImage(_ image: UIImage) -> CGRect {
        return CGRect(
            x: image.capInsets.left / image.size.width,
            y: image.capInsets.top / image.size.height,
            width: (image.size.width - image.capInsets.right - image.capInsets.left) / image.size.width,
            height: (image.size.height - image.capInsets.bottom - image.capInsets.top) / image.size.height
        )
    }
    
}


