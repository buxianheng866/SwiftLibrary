//
//  KBCustomBaseView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/17.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class KBCustomBaseView: UIView {
    
    lazy var collectionView: UICollectionView = {

        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collect.backgroundColor = kChatKeyboardBgColor
        collect.showsVerticalScrollIndicator = true
        collect.showsHorizontalScrollIndicator = false
        collect.isPagingEnabled = true
        collect.dataSource = self
        collect.delegate = self
        return collect
    }()

    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 0
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.lightGray
        page.backgroundColor = UIColor.clear
        return page
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kChatKeyboardBgColor
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() -> Void {
        
    }
    
}

extension KBCustomBaseView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOff = scrollView.contentOffset.x
        let page = contentOff / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
    
}

