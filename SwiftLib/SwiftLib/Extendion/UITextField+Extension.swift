//
//  UITextField+Extension.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/21.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
extension UITextField {
    
    /*!
     @method
     @abstract 只输入数字 在任何键盘下
     */
    func validateNumberByExp(exp: String) -> Bool {
        var isValid = true
        let length = exp.count
        if length > 0 {
            let numberRegex = "^[0-9]*$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
            isValid = predicate.evaluate(with: exp)
        }
        return isValid
    }
    
}
