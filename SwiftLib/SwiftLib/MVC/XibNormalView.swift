//
//  XibNormalView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/13.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class XibNormalView: UIView {
    
    class func newInstance() -> XibNormalView? {
        let nib = Bundle.main.loadNibNamed( String(describing: self), owner: nil, options: nil)
        guard let nibView = nib?.first as? XibNormalView else { return nil }
        return nibView
    }

}
