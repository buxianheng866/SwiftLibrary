//
//  UIColor+Extension.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/12.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    class func hexInt(_ hex: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0,
                       
                       green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0,
                       
                       blue: ((CGFloat)(hex & 0xFF)) / 255.0,
                       
                       alpha: 1.0)
    }
    
    func transImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage ?? UIImage()
    }
}
