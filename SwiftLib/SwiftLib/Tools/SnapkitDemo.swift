//
//  SnapkitDemo.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import SnapKit

//make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))

//make.left.equalTo(view1.snp.left).offset(10)

//make.size.equalTo(CGSize(width: 100, height: 100))


//更新视图
//view2.snp.makeConstraints { (make) in
//    make.width.height.equalTo(100)  // 宽高为100
//    self.updateConstraint = make.top.left.equalTo(10).constraint   // 距离父视图上、左为10
//}
// 更新约束
//func updateConstraintMethod() {
//    self.updateConstraint?.update(offset: 50)   // 更新距离父视图上、左为50
//}



//view2.snp.makeConstraints { (make) in
//    // 让顶部距离view1的底部为10的距离
//    make.top.equalTo(view1.snp.bottom).offset(10)
//    // 设置宽、高
//    make.width.height.equalTo(100)
//    // 水平中心线<=view1的左边
//    make.centerX.lessThanOrEqualTo(view1.snp.leading)
//}
//
