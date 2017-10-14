//
//  LPVerticalBtn.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/13.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
class LPVerticalBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let radio: CGFloat = 0.7
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: contentRect.size.width, height: contentRect.size.height * 0.7)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: contentRect.size.height * radio, width: contentRect.size.width, height: contentRect.size.height * (1 - radio))
    }
}



