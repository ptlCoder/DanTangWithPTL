//
//  PTLSpCollectionCell.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/31.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLSpCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
    }

}
