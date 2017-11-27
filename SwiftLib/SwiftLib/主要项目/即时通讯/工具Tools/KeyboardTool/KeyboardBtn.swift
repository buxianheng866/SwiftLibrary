//
//  KeyboardBtn.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/10.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class KeyboardBtn: UIButton {
    
    
    class func creatBtn() -> KeyboardBtn {
        let btn = KeyboardBtn(type: .custom)
        return btn
    }
    
    func setImg(aImg: UIImage, bImg: UIImage) {
        self.setImage(aImg, for: .normal)
        self.setImage(bImg, for: .highlighted)
    }
    
    func setVoiceImg() {
        let aImg = self.isSelected ? #imageLiteral(resourceName: "ToolViewKeyboard") : #imageLiteral(resourceName: "ToolViewInputVoice")
        let bImg = self.isSelected ? #imageLiteral(resourceName: "ToolViewKeyboardHL") : #imageLiteral(resourceName: "ToolViewInputVoiceHL")
        setImg(aImg: aImg, bImg: bImg)
    }
    
    func setEomjImg() {
        let aImg = self.isSelected ? #imageLiteral(resourceName: "ToolViewKeyboard") : #imageLiteral(resourceName: "ToolViewEmotion")
        let bImg = self.isSelected ? #imageLiteral(resourceName: "ToolViewKeyboardHL") : #imageLiteral(resourceName: "ToolViewEmotionHL")
        setImg(aImg: aImg, bImg: bImg)
    }
    
   
    
    
}
