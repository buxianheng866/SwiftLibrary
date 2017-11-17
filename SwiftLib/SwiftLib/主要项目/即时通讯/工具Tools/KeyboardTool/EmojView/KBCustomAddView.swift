//
//  KBCustomAddView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/17.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class KBCustomAddView: KBCustomBaseView {
    
    override func setUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        self.collectionView.frame = self.frame
        self.addSubview(self.collectionView)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
}
