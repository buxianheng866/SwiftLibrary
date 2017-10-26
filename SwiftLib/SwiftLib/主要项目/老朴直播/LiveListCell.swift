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
    var model: LiveDetail? {
        didSet {
            name.text = model?.nickname
            header.kf.setImage(with: URL(string: (model?.avatar_small)!))
            contentImage.kf.setImage(with: URL(string: (model?.room_src)!))
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
