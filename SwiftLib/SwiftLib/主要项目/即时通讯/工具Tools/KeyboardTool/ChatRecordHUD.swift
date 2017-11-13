//
//  ChatRecordHUD.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/11.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatRecordHUD: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
