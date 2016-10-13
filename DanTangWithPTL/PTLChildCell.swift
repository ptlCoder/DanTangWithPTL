//
//  PTLChildCell.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import Kingfisher
class PTLChildCell: UITableViewCell {

    /// 图片
    @IBOutlet weak var imageIconView: UIImageView!
    /// 点赞
    @IBOutlet weak var likeButton: UIButton!
    /// 描述
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageIconView.layer.cornerRadius = 5.0
        imageIconView.layer.masksToBounds = true
        
        likeButton.layer.cornerRadius = likeButton.frame.height*0.5
        likeButton.layer.masksToBounds = true
    }

    var model:PTLChildItem? {
        didSet{
            imageIconView.kf_setImageWithURL(NSURL(string: (model?.cover_image_url)!))
            titleLabel.text = model?.title
            likeButton.setTitle(" " + String(model?.likes_count ?? 0), forState: UIControlState())
        }
    }
    
}
