//
//  PTLDetailGoodsViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import MJRefresh

class PTLDetailGoodsViewController: UIViewController, UIScrollViewDelegate {

    /// 模型数据
    var product: PTLProduct?
    /// 顶部滚动视图
    @IBOutlet weak var scrollView: UIScrollView!
    /// 底部工具条
    @IBOutlet weak var bottomView: UIView!
    /// 上部分view的约束
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    /// 下部分view的约束
    @IBOutlet weak var bottomViewHeightContraint: NSLayoutConstraint!
    /// 图片滚动视图View
    @IBOutlet weak var topImageView: PTLImageView!
    /// 标题
    @IBOutlet weak var nameLabel: UILabel!
    /// 价格
    @IBOutlet weak var priceLabel: UILabel!
    /// 描述
    @IBOutlet weak var descriptionLabel: UILabel!
    /// 红色View左边约束
    @IBOutlet weak var redViewLeftContraint: NSLayoutConstraint!
    /// 图文介绍按钮
    @IBOutlet weak var textIntroduceButton: UIButton!
    /// 评论按钮
    @IBOutlet weak var commentButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        topImageView.product = product
        nameLabel.text = product?.name
        priceLabel.text = product?.price
        descriptionLabel.text = product?.describe
        
        textIntroduceButton.tag = 1010
        commentButton.tag = 1011
    
        
        bottomViewHeightContraint.constant = 509 - 37 + 150
        scrollView.delegate = self
        scrollView.bounces = false
    }


    @IBAction func redViewContraintChange(sender: UIButton) {
        if sender.tag == 1010 {
            redViewLeftContraint.constant = 0
        }else
        {
            redViewLeftContraint.constant = kScreenWidth/2
        }
        
        UIView.animateWithDuration(0.25) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 472-64 {
            offsetY = 472-64
            scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
        }
    }

}
