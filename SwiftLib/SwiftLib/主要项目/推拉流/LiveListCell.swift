//
//  LiveListCell.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/25.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import Kingfisher
class LiveListCell: UITableViewCell {

    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var model: ViewListModel? {
        didSet {
            name.text = model?.creator.nick
            
            var  imageUrl = model?.creator.portrait
            /* 处理特殊图片地址 */
            if (imageUrl?.hasPrefix("http://img2.inke.cn/"))! == false {
                imageUrl = "http://img.meelive.cn/" + (model?.creator.portrait)!
            }
            
            header.kf.setImage(with: URL(string: imageUrl!))
            contentImage.kf.setImage(with: URL(string: imageUrl!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
