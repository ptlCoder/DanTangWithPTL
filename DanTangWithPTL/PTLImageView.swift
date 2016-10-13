//
//  PTLImageView.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/13.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SDCycleScrollView

class PTLImageView: UIView {

    var cycleScrollView = SDCycleScrollView()
    
    var product: PTLProduct? {
        didSet{
           cycleScrollView.imageURLStringsGroup = product?.image_urls
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    // MARK: 添加滚动视图
    @objc private func setupUI() {
        
        cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: frame.height))
        addSubview(cycleScrollView)
        self.autoresizingMask = UIViewAutoresizing()
        
    }
}
