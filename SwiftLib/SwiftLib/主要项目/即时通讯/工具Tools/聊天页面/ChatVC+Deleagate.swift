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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mScreenW, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellcell", for: indexPath) as! ChatBaseCell
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    
    
    
}
