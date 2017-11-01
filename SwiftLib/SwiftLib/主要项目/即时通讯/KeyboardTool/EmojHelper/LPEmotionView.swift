//
//  LPEmotionView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/31.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
fileprivate let kNumberOfOneRow = 8  //一行8个
fileprivate let kRow = 3     // 共3行
fileprivate let kAllNumerOfPage = kRow * kNumberOfOneRow //一页共多少
fileprivate let cellIdentifier = "emojCellIdentifier"

class LPEmotionView: UIView {

    var selectEmotionBlock: ((LPEmotionView,LPEmotion) -> ())?
    var selectSendBlock: ((LPEmotionView) -> ())?
    
    lazy var emotions: [LPEmotion] = {
        return LPEmotionHelper.getAllEmotions()
    }()
    
    lazy var bottomView: UIView = { [unowned self] in
        let bottomV = UIView()
        bottomV.backgroundColor = UIColor.white
        bottomV.addSubview(self.addButton)
        bottomV.addSubview(self.emotionButton)
        bottomV.addSubview(self.sendButton)
        return bottomV
        }()
    
    lazy var addButton: UIButton = {
        let addBtn = UIButton(type: .custom)
        addBtn.backgroundColor = UIColor.white
        addBtn.addTarget(self, action: #selector(addBtnAction(_:)), for: .touchUpInside)
        addBtn.setImage(#imageLiteral(resourceName: "Card_AddIcon"), for: .normal)
        return addBtn
    }()
    
    lazy var sendButton: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        sendBtn.backgroundColor = UIColor(red:0.13, green:0.41, blue:0.79, alpha:1.00)
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.addTarget(self, action: #selector(sendBtnAction(_:)), for: .touchUpInside)
        return sendBtn
        }()
    
    lazy var emotionButton: UIButton = {
        let emotionBtn = UIButton(type: .custom)
        emotionBtn.backgroundColor = kChatKeyboardBgColor
        emotionBtn.addTarget(self, action: #selector(emtionBtnAct(_:)), for: .touchUpInside)
        emotionBtn.setImage(#imageLiteral(resourceName: "EmotionsEmojiHL"), for: .normal)
        return emotionBtn
    }()
    
    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages =  self.emotions.count / kAllNumerOfPage + self.emotions.count % kAllNumerOfPage == 0 ? 0 : 1
        page.currentPage = 0
        page.pageIndicatorTintColor = UIColor.lightGray
        page.backgroundColor = kChatKeyboardBgColor
        return page
    }()
    
    lazy var collectionView: UICollectionView = {
        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collect.backgroundColor = kChatKeyboardBgColor
        collect.register(EmotionCollectCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collect.isPagingEnabled = true
        collect.dataSource = self
        collect.delegate = self
        return collect
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(bottomView)
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        
        bottomView.snp.makeConstraints { (snp) in
            snp.left.right.bottom.equalTo(self)
            snp.height.equalTo(38)
        }
        
        addButton.snp.makeConstraints { (snp) in
            snp.top.left.bottom.equalTo(bottomView)
            snp.width.equalTo(45)
        }
        emotionButton.snp.makeConstraints { (snp) in
            snp.top.bottom.equalTo(bottomView)
            snp.left.equalTo(addButton.snp.right)
            snp.width.equalTo(45)
        }
        sendButton.snp.makeConstraints { (snp) in
            snp.top.bottom.right.equalTo(bottomView)
            snp.width.equalTo(53)
        }
        collectionView.snp.makeConstraints { (snp) in
            snp.left.top.right.equalTo(self)
            snp.height.equalTo(160)
        }
        pageControl.snp.makeConstraints { (snp) in
            snp.left.right.equalTo(self)
            snp.top.equalTo(collectionView.snp.bottom).offset(-6)
            snp.bottom.equalTo(bottomView.snp.top)
        }
    }
    
    
}
extension LPEmotionView {
    @objc func addBtnAction(_ btn: UIButton) -> Void {
        printLog("添加表情")
    }
    
    @objc func emtionBtnAct(_ btn: UIButton) -> Void {
        printLog("自带表情")
    }
    
    @objc func sendBtnAction(_ btn: UIButton) -> Void {
        printLog("发送")
        if selectSendBlock != nil {
            selectSendBlock!(self)
        }
    }
}

extension LPEmotionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.emotions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}


class EmotionCollectCell: UICollectionViewCell {
    var emtion: LPEmotion? {
        didSet {
            guard let emo = emtion else { return }
            if emo.isEmpty {
               emoImge.image = #imageLiteral(resourceName: "DeleteEmoticonBtn")
            } else if emo.isEmpty {
                emoImge.image = UIImage()
            } else {
                guard let path = emo.imgPath else { return }
                emoImge.image = UIImage(contentsOfFile: path)
            }
        }
    }
    lazy var emoImge: UIImageView = {
        return UIImageView()
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(emoImge)
        emoImge.snp.makeConstraints { snp in
            snp.center.equalTo(self.snp.center)
            snp.width.height.equalTo(32)
        }
    }
}



