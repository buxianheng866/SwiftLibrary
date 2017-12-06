//
//  ChatVC+Deleagate.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

extension ChatViewController: LPChatKeyboradDelegate {
    
    func sendMessage(messg: String) {
        scrollToBottom()
        printLog("message: \(messg)")
        
    }
    
    func aboveViewScrollToBottom() {
        scrollToBottom()
    }
    
}



extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChatMsgManager.default.messageSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let md = ChatMsgManager.default.messageSource![indexPath.item]
        return CGSize(width: mScreenW, height: md.frame.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellcell", for: indexPath) as! ChatBaseCell
        cell.backgroundColor = UIColor.orange
        if let data = ChatMsgManager.default.messageSource {
            let md = data[indexPath.item]
            cell.message = md
        }
        return cell
    }
    
    
    
    
}
