//
//  PTLHeaderView.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/7.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLHeaderView: UITableViewCell {

    /// 背景图
    @IBOutlet weak var bgImageView: UIImageView!
    /// 消息
    @IBOutlet weak var messageButton: UIButton!
    /// 设置
    @IBOutlet weak var settingButton: UIButton!
    /// 名字
    @IBOutlet weak var nameLabel: UILabel!
    /// 头像
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
}
