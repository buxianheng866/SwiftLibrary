//
//  KBCustomAddView.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/17.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

class KBCustomAddView: KBCustomBaseView {
    
    lazy var dataSource = {
       return BarHelper.getAdds()
    }()
    override func setUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = LPHorizontalLayout(column: 4, row: 2)
        collectionView.register(CustomAddCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView.isPagingEnabled = true
        self.addSubview(self.collectionView)
        
        
        pageControl.numberOfPages = dataSource.count / 8 + (dataSource.count % 8 == 0 ? 0 : 1)
        self.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(15)
            make.bottom.equalTo(pageControl.snp.top).offset(0)
        }
        pageControl.snp.makeConstraints { (make) in
            make.right.left.bottom.equalTo(0)
            make.height.equalTo(20)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CustomAddCell
        let md = dataSource[indexPath.item]
        cell.model = md
        return cell
    }
}


class CustomAddCell: UICollectionViewCell {
    var model: LPAddModel? {
        didSet {
            lab.text = model?.name
            btn.setImage(UIImage(named: (model?.image)!), for: .normal)
        }
    }
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor(hexString: "#dedddd")?.cgColor
        btn.layer.borderWidth = 0.5
        let img0 = UIImage(color: UIColor.white)
        let img1 = UIImage(color: RGBA(r: 237, g: 237, b: 246, a: 1))
        btn.setBackgroundImage(img0, for: .normal)
        btn.setBackgroundImage(img1, for: .highlighted)
        btn.addTarget(self, action: #selector(actionSelected), for: .touchUpInside)
        return btn
    }()
    
    lazy var lab: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = UIColor.gray
        lb.font = UIFont.systemFont(ofSize: 11.0)
        return lb
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(btn)
        self.addSubview(lab)
        
        lab.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(21)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
        }
        
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(6)
            make.bottom.equalTo(lab.snp.top).offset(-5)
            make.width.equalTo(btn.snp.height)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    @objc func actionSelected() -> Void {
        
    }
    
    
}



