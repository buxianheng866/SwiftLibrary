//
//  ChatRecordHUD.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/11.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatRecordHUD: UIImageView {
  
    var imageData = [#imageLiteral(resourceName: "RD_Voice_1"),#imageLiteral(resourceName: "RD_Voice_2"),#imageLiteral(resourceName: "RD_Voice_3"),#imageLiteral(resourceName: "RD_Voice_4"),#imageLiteral(resourceName: "RD_Voice_5"),#imageLiteral(resourceName: "RD_Voice_6")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.animationDuration = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isVoiceValue(value: Float) {
        if value == 0  {
            self.animationImages = nil
            self.stopAnimating()
            return
        }
        if value >= 0.7 {
            self.animationImages = [imageData[3],imageData[4],imageData[5],imageData[4],imageData[3]]
        } else {
            self.animationImages = [imageData[0],imageData[1],imageData[2],imageData[1]]
        }
        self.startAnimating()
    }
    
    
    
}
