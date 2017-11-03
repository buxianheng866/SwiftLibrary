//
//  DownloadCell.swift
//  SwiftLib
//
//  Created by nb616 on 2017/11/3.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    var model: DownloadViedoModel! {
        didSet {
            nameLab.text = model.filename
        }
    }
    var downloadCellBlock: ((DownloadViedoModel) -> ())?
    var deleteCellBlock: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func playAction(_ sender: Any) {
        downloadCellBlock!(model)
    }
    
    
    @IBAction func deleAction(_ sender: Any) {
        downloadDelete(model.filePath!)
        deleteCellBlock!()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
