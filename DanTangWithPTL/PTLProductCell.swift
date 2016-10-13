//
//  PTLProductCell.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDWebImage

/**
 *  协议
 */
protocol PTLProductCellDelegate: NSObjectProtocol {
    func collectionViewCellDidClickedLikeButton(button: UIButton)
}


class PTLProductCell: UICollectionViewCell {

    weak var delegate: PTLProductCellDelegate?
    
    /// 头像
    @IBOutlet weak var imageViewIcon: UIImageView!
    /// 价格
    @IBOutlet weak var priceLabel: UILabel!
    ///赞
    @IBOutlet weak var zanButton: UIButton!
    /// 标题
    @IBOutlet weak var titleLabel: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        titleLabel.showsVerticalScrollIndicator = false
//        titleLabel.isUserInteractionEnabled = false
    }
    
    var product : PTLProduct? {
        didSet {
            
            let url = product?.cover_image_url
            
            imageViewIcon.sd_setImageWithURL(NSURL(string: url!))
            titleLabel.text = product?.name
            priceLabel.text = "￥" + (product?.price)!
            zanButton.setTitle("❤️ " + String(product!.favorites_count!), forState:UIControlState())
        }
    }
    
    // MARK: 点赞
    @IBAction func likeButtonClick(sender: UIButton) {
        delegate?.collectionViewCellDidClickedLikeButton(sender)
    }

}

