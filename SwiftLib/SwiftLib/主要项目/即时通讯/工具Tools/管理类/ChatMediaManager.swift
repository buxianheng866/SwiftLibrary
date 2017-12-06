//
//  ChatMediaManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/12/6.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class ChatMediaManager: NSObject {
    
    let `default`: ChatMediaManager = {
        let cm = ChatMediaManager()
        NIMSDK.shared().mediaManager.add(cm as NIMMediaManagerDelegate)
        return cm
    }()
    
    
    func needProximityMonitor(need: Bool) {
        NIMSDK.shared().mediaManager.setNeedProximityMonitor(need)
        
        
    }
}

extension ChatMediaManager: NIMMediaManagerDelegate {
    
}

